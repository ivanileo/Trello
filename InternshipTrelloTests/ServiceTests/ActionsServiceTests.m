//
//  ActionsServiceTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 06.12.2021.
//

#import <XCTest/XCTest.h>

#import "ActionsListRequest.h"
#import "ActionsService.h"
#import "MockNetworkManager.h"

@interface ActionsServiceTests : XCTestCase

@end

@implementation ActionsServiceTests {
    ActionsService *_sut;
    MockNetworkManager *_mockNetworkManager;
}

- (void)setUp {
    _mockNetworkManager = [[MockNetworkManager alloc] init];
    _sut = [[ActionsService alloc] initWithNetworkManager:_mockNetworkManager];
}

- (void)tearDown {
    _mockNetworkManager = nil;
    _sut = nil;
}

- (void)testGetActionsListShouldHandleValidModel {
    _mockNetworkManager.behavior = ShouldReturnValidData;
    [_sut getActionsListWithBeforeActionId:@"validBeforeId"
                             andCompletion:^(ActionsListModel * _Nullable model,
                                             NSError * _Nullable error) {
        XCTAssertNotNil(model);
        XCTAssertEqual(model.class, ActionsListModel.class);
        XCTAssertNil(error);
        for (NSInteger index = 0; index < model.items.count; index++) {
            NSString *validActionId = [NSString stringWithFormat:@"validId%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].actionId, validActionId);
            NSString *validType = [NSString stringWithFormat:@"validType%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].type, validType);
            NSString *validDate = [NSString stringWithFormat:@"validDate%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].date, validDate);
            NSString *validUsername = [NSString stringWithFormat:@"validUsername%ld", index + 1];
            XCTAssertEqualObjects(model.items[index].username, validUsername);
        }
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 1);
    XCTAssertTrue([_mockNetworkManager.receivedRequests[0] isKindOfClass:ActionsListRequest.class]);
}

- (void)testGetActionsListShouldHandleError {
    _mockNetworkManager.behavior = ShouldReturnError;
    [_sut getActionsListWithBeforeActionId:@"validBeforeId"
                             andCompletion:^(ActionsListModel * _Nullable model,
                                             NSError * _Nullable error) {
        XCTAssertNil(model);
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.localizedDescription, @"Error occured in mocked NetworkManager!");
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 1);
    XCTAssertTrue([_mockNetworkManager.receivedRequests[0] isKindOfClass:ActionsListRequest.class]);
}

@end
