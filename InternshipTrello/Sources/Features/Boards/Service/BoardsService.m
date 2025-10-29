//
//  BoardsService.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 08.11.2021.
//

#import "BoardCardsRequest.h"
#import "BoardCategoriesRequest.h"
#import "BoardDetailsRequest.h"
#import "BoardsListRequest.h"
#import "BoardsService.h"
#import "CardsListModel.h"
#import "NetworkManager.h"
#import "NSObject+Identifier.h"

NS_ASSUME_NONNULL_BEGIN

/** Error domain const.*/
static NSString *const kBoardsServiceErrorDomain = @"BoardsServiceErrorDomain";

/** Boards service errors.*/
typedef NS_ENUM(NSInteger, BoardsServiceErrorCode) {
    BoardsServiceErrorCodeUnexpectedModel = 1
};

typedef void (^BoardDetailsCompletion)(BoardDetailsModel * _Nullable, NSError * _Nullable);

typedef void (^BoardCardsCompletion)(CardsListModel * _Nullable, NSError * _Nullable);

typedef void (^BoardCategoriesCompletion)(CategoriesListModel * _Nullable, NSError * _Nullable);


@implementation BoardsService {
    id<NetworkManagerProtocol> _networkManager;
    DataStorageService *_dataStorageService;
}

- (instancetype)init {
    return [self initWithNetworkManager:NetworkManager.shared andDataSorageService:DataStorageService.shared];
}

- (instancetype)initWithNetworkManager:(id<NetworkManagerProtocol>)networkManager                                                      andDataSorageService:(DataStorageService *)dataStorageService {
    self = [super init];
    if (self) {
        _networkManager = networkManager;
        _dataStorageService = dataStorageService;
    }
    return self;
}

#pragma mark - Public methods

- (void)getBoardContentWithBoardId:(NSString *)boardId andCompletion:(BoardContentCompletion)completion {
    __block BoardDetailsModel *boardDetailsModel;
    __block CardsListModel *cardsListModel;
    __block CategoriesListModel *categoriesListModel;
    NSMutableArray<NSError *> *occuredErrors = [[NSMutableArray alloc] init];
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    dispatch_group_enter(dispatchGroup);
    [self getBoardDetailsWithBoardId:boardId andCompletion:^(BoardDetailsModel * _Nullable model,
                                                             NSError * _Nullable error) {
        if (error) {
            [occuredErrors addObject:error];
        } else {
            boardDetailsModel = model;
        }
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_enter(dispatchGroup);
    [self getBoardCardsWithBoardId:boardId andCompletion:^(CardsListModel * _Nullable model,
                                                           NSError * _Nullable error) {
        if (error) {
            [occuredErrors addObject:error];
        } else {
            cardsListModel = model;
        }
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_enter(dispatchGroup);
    [self getBoardCategoriesWithBoardId:boardId andCompletion:^(CategoriesListModel * _Nullable model,
                                                                NSError * _Nullable error) {
        if (error) {
            [occuredErrors addObject:error];
        } else {
            categoriesListModel = model;
        }
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_notify(dispatchGroup, dispatchQueue, ^{
        if (occuredErrors.count > 0) {
            completion(nil, occuredErrors);
        } else if (boardDetailsModel && categoriesListModel && cardsListModel) {
            boardDetailsModel.categories = categoriesListModel;
            for (CategoriesListItemModel *category in categoriesListModel.items) {
                for (CardsListItemModel *card in cardsListModel.items) {
                    if ([category.categoryId isEqualToString:card.categoryId]) {
                        [category.cards addObject:card];
                    }
                }
            }
            completion(boardDetailsModel, nil);
        }
    });
}

- (void)getCachedBoardsWithUpdatingAndCompletion:(BoardsListCompletion)completion {
    NSArray<Board *> *cachedBoards = (NSArray<Board *> *)[DataStorageService.shared getEntitiesForName:Board.identifier];
    if (cachedBoards) {
        BoardsListModel *cachedModel = [[BoardsListModel alloc] initWithBoards:cachedBoards];
        completion(cachedModel, nil);
    }
    BoardsListRequest *boardsListRequest = [[BoardsListRequest alloc] init];
    [_networkManager sendRequest:boardsListRequest
                  withCompletion:^(id<SerializableModel> _Nullable model, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            completion(nil, error);
            return;
        }
        completion(model, nil);
        BoardsListModel *newModel = (BoardsListModel *)model;
        [self saveBoardsToCache:newModel];
    }];
}

- (void)getCachedBoardsListWithCompletion:(BoardsListCompletion)completion {
    NSArray<Board *> *cachedBoards = (NSArray<Board *> *)[DataStorageService.shared getEntitiesForName:Board.identifier];
    if (cachedBoards) {
        BoardsListModel *cachedModel = [[BoardsListModel alloc] initWithBoards:cachedBoards];
        completion(cachedModel, nil);
    }
}

- (void)getBoardsListWithCompletion:(BoardsListCompletion)completion {
    BoardsListRequest *boardsListRequest = [[BoardsListRequest alloc] init];
    [_networkManager sendRequest:boardsListRequest
                  withCompletion:^(id<SerializableModel> _Nullable model, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            completion(nil, error);
            return;
        }
        completion(model, nil);
        BoardsListModel *newModel = (BoardsListModel *)model;
        [self saveBoardsToCache:newModel];
    }];
}

#pragma mark - Private methods

- (void)getBoardDetailsWithBoardId:(NSString *)boardId andCompletion:(BoardDetailsCompletion)completion {
    BoardDetailsRequest *boardDetailsRequest = [[BoardDetailsRequest alloc] init];
    boardDetailsRequest.boardId = boardId;
    [_networkManager sendRequest:boardDetailsRequest
                  withCompletion:^(id<SerializableModel> _Nullable model, NSError * _Nullable error) {
        completion(model, error);
    }];
}

- (void)getBoardCardsWithBoardId:(NSString *)boardId andCompletion:(BoardCardsCompletion)completion {
    BoardCardsRequest *boardCardsRequest = [[BoardCardsRequest alloc] init];
    boardCardsRequest.boardId = boardId;
    [_networkManager sendRequest:boardCardsRequest
                  withCompletion:^(id<SerializableModel> _Nullable model, NSError * _Nullable error) {
        completion(model, error);
    }];
}

- (void)getBoardCategoriesWithBoardId:(NSString *)boardId andCompletion:(BoardCategoriesCompletion)completion {
    BoardCategoriesRequest *boardCategoriesRequest = [[BoardCategoriesRequest alloc] init];
    boardCategoriesRequest.boardId = boardId;
    [_networkManager sendRequest:boardCategoriesRequest
                  withCompletion:^(id<SerializableModel> _Nullable model, NSError * _Nullable error) {
        completion(model, error);
    }];
}

- (void)saveBoardsToCache:(BoardsListModel *)model {
    [DataStorageService.shared clearEntitiesForName:Board.identifier];
    for (BoardsListItemModel *item in model.items) {
        [DataStorageService.shared saveEntityForName:Board.identifier
                                            andSetup:^(NSManagedObject * _Nonnull object) {
            Board *newBoard = (Board *)object;
            newBoard.name = item.name;
            newBoard.imageUrl = item.imageUrl;
            newBoard.boardId = item.boardId;
        }];
    }
}

@end

NS_ASSUME_NONNULL_END
