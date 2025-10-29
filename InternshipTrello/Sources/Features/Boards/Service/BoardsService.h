//
//  BoardsService.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 08.11.2021.
//

#import <Foundation/Foundation.h>

#import "BoardDetailsModel.h"
#import "BoardsListModel.h"
#import "DataStorageService.h"
#import "NetworkManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/** Type of completion block for handling boards list model result. */
typedef void (^BoardsListCompletion)(BoardsListModel * _Nullable,  NSError * _Nullable);

/** Type of completion block for handling board details model result. */
typedef void (^BoardContentCompletion)(BoardDetailsModel * _Nullable,  NSArray<NSError *> * _Nullable);

/**
 * Performs actions for fetching lists of boards to show.
 */
@interface BoardsService : NSObject

/**
 * Creates BoardsService with specific NetworkNamagerProtocol object.
 *
 * @param networkManager object that conforms protocol NetworkManagerProtocol.
 * @param dataStorageService DataStorageService for saving entities.
 */
- (instancetype)initWithNetworkManager:(id<NetworkManagerProtocol>)networkManager                                                      andDataSorageService:(DataStorageService *)dataStorageService;

/**
 * Returns board details or error in completion block.
 *
 * @param boardId board id that will be requested.
 * @param completion completion block to handle result or error.
 */
- (void)getBoardContentWithBoardId:(NSString *)boardId andCompletion:(BoardContentCompletion)completion;

/**
 * Returns list of boards for current user or error in completion block.
 *
 * @param completion completion block to handle result or error.
 */
- (void)getBoardsListWithCompletion:(BoardsListCompletion)completion;

/**
 * Returns list of cached boards for current user or error in completion block.
 *
 * @param completion completion block to handle result or error.
 */
- (void)getCachedBoardsListWithCompletion:(BoardsListCompletion)completion;

/**
 * Returns list of cached boards for current user or error in completion block. After that makes
 * network request, returns new boards in completion block and updates cache.
 *
 * @param completion completion block to handle result or error.
 */
- (void)getCachedBoardsWithUpdatingAndCompletion:(BoardsListCompletion)completion;

@end

NS_ASSUME_NONNULL_END
