//
//  BoardsServiceTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 16.11.2021.
//

#import <XCTest/XCTest.h>

#import "BoardsListRequest.h"
#import "BoardsService.h"
#import "NSObject+Identifier.h"
#import "MockNetworkManager.h"

@interface BoardsServiceTests : XCTestCase

@end

@implementation BoardsServiceTests {
    BoardsService *_sut;
    MockNetworkManager *_mockNetworkManager;
    DataStorageService *_dataStorageService;
}

- (void)setUp {
    _mockNetworkManager = [[MockNetworkManager alloc] init];
    _dataStorageService = [[DataStorageService alloc] initWithModelName:@"TestModel"];
    [_dataStorageService clearEntitiesForName:Board.identifier];
    _sut = [[BoardsService alloc] initWithNetworkManager:_mockNetworkManager andDataSorageService:_dataStorageService];
}

- (void)tearDown {
    _dataStorageService = nil;
    _mockNetworkManager = nil;
    _sut = nil;
}

- (void)testGetBoardsListShouldHandleValidModel {
    _mockNetworkManager.behavior = ShouldReturnValidData;
    [_sut getBoardsListWithCompletion:^(BoardsListModel * _Nullable model, NSError * _Nullable error) {
        XCTAssertNotNil(model);
        XCTAssertEqual(model.class, BoardsListModel.class);
        XCTAssertNil(error);
        for (NSInteger index = 0; index < model.items.count; index++) {
            NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].name, validName);
            NSString *validId = [NSString stringWithFormat:@"validId%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].boardId, validId);
            NSString *validImage = [NSString stringWithFormat:@"validBackgroundImage%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].imageUrl, validImage);
        }
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 1);
    XCTAssertTrue([_mockNetworkManager.receivedRequests[0] isKindOfClass:BoardsListRequest.class]);
}

- (void)testGetBoardsListShouldHandleError {
    _mockNetworkManager.behavior = ShouldReturnError;
    [_sut getBoardsListWithCompletion:^(BoardsListModel * _Nullable model, NSError * _Nullable error) {
        XCTAssertNil(model);
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.localizedDescription, @"Error occured in mocked NetworkManager!");
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 1);
    XCTAssertTrue([_mockNetworkManager.receivedRequests[0] isKindOfClass:BoardsListRequest.class]);
}

- (void)testGetBoardContentShouldHandleValidModel {
    _mockNetworkManager.behavior = ShouldReturnValidData;
    XCTestExpectation *expectation = [self expectationWithDescription:@"complete"];
    __block BoardDetailsModel *returnedModel = nil;
    [_sut getBoardContentWithBoardId:@"validId" andCompletion:^(BoardDetailsModel * _Nullable model,
                                                                NSArray<NSError *> * _Nullable errors) {
        returnedModel = model;
        [expectation fulfill];
    }];
    
    __weak __typeof__(self) weakSelf = self;
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        __typeof__(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        XCTAssertNil(error);
        XCTAssertEqual(returnedModel.categories.items.count, 3);
        XCTAssertEqual(returnedModel.categories.items[0].cards.count, 3);
        XCTAssertEqual(returnedModel.categories.items[1].cards.count, 2);
        XCTAssertEqual(returnedModel.categories.items[2].cards.count, 1);
        XCTAssertEqual(strongSelf->_mockNetworkManager.receivedRequests.count, 3);
    }];
}

- (void)testGetBoardContentShouldHandleErrors {
    _mockNetworkManager.behavior = ShouldReturnError;
    XCTestExpectation *expectation = [self expectationWithDescription:@"complete"];
    __block NSArray<NSError *> *occuredErrors = nil;
    [_sut getBoardContentWithBoardId:@"validId" andCompletion:^(BoardDetailsModel * _Nullable model,
                                                                NSArray<NSError *> * _Nullable errors) {
        occuredErrors = errors;
        [expectation fulfill];
    }];
    
    __weak __typeof__(self) weakSelf = self;
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        __typeof__(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        XCTAssertNil(error);
        XCTAssertEqual(occuredErrors.count, 3);
        XCTAssertEqual(strongSelf->_mockNetworkManager.receivedRequests.count, 3);
        for (NSError *error in occuredErrors) {
            XCTAssertEqualObjects(error.localizedDescription, @"Error occured in mocked NetworkManager!");
        }
    }];
}

- (void)testGetCachedBoardsList {
    [_dataStorageService saveEntityForName:Board.identifier
                                  andSetup:^(NSManagedObject * _Nonnull object) {
        Board *newBoard = (Board *)object;
        newBoard.name = @"validName1";
        newBoard.imageUrl = @"validBackgroundImage1";
        newBoard.boardId = @"validId1";
    }];
    [_dataStorageService saveEntityForName:Board.identifier
                                  andSetup:^(NSManagedObject * _Nonnull object) {
        Board *newBoard = (Board *)object;
        newBoard.name = @"validName2";
        newBoard.imageUrl = @"validBackgroundImage2";
        newBoard.boardId = @"validId2";
    }];
    [_sut getCachedBoardsListWithCompletion:^(BoardsListModel * _Nullable model,
                                              NSError * _Nullable error) {
        XCTAssertNotNil(model);
        XCTAssertEqual(model.class, BoardsListModel.class);
        XCTAssertNil(error);
        for (NSInteger index = 0; index < model.items.count; index++) {
            NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].name, validName);
            NSString *validId = [NSString stringWithFormat:@"validId%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].boardId, validId);
            NSString *validImage = [NSString stringWithFormat:@"validBackgroundImage%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].imageUrl, validImage);
        }
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 0);
}

@end
