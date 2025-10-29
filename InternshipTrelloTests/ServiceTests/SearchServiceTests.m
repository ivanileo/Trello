//
//  SearchServiceTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 13.12.2021.
//

#import <XCTest/XCTest.h>

#import "MockNetworkManager.h"
#import "SearchRequest.h"
#import "SearchService.h"

@interface SearchServiceTests : XCTestCase

@end

@implementation SearchServiceTests {
    SearchService *_sut;
    MockNetworkManager *_mockNetworkManager;
}

- (void)setUp {
    _mockNetworkManager = [[MockNetworkManager alloc] init];
    _sut = [[SearchService alloc] initWithNetworkManager:_mockNetworkManager];
}

- (void)tearDown {
    _mockNetworkManager = nil;
    _sut = nil;
}

- (void)testSearchShouldHandleValidModel {
    _mockNetworkManager.behavior = ShouldReturnValidData;
    [_sut searchWithQuery:@"validQuery"
            andCompletion:^(SearchResultModel * _Nullable model,
                            NSString * _Nonnull query,
                            NSError * _Nullable error) {
        XCTAssertEqualObjects(query, @"validQuery");
        XCTAssertNotNil(model.boards);
        XCTAssertEqual(model.boards.class, BoardsListModel.class);
        XCTAssertNotNil(model.cards);
        XCTAssertEqual(model.cards.class, CardsListModel.class);
        XCTAssertNil(error);
        for (NSInteger index = 0; index < model.boards.items.count; index++) {
            NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
            XCTAssertEqualObjects(model.boards.items[index].name, validName);
            NSString *validId = [NSString stringWithFormat:@"validId%ld", index + 1];
            XCTAssertEqualObjects(model.boards.items[index].boardId, validId);
            NSString *validImage = [NSString stringWithFormat:@"validBackgroundImage%ld", index + 1];
            XCTAssertEqualObjects(model.boards.items[index].imageUrl, validImage);
        }
        for (NSInteger index = 0; index < model.cards.items.count; index++) {
            NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
            XCTAssertEqualObjects(model.cards.items[index].name, validName);
            NSString *validCardId = [NSString stringWithFormat:@"validId%ld", index + 1];
            XCTAssertEqualObjects(model.cards.items[index].cardId, validCardId);
            NSString *validCategoryId = [NSString stringWithFormat:@"validCategoryId%ld", index + 1];
            XCTAssertEqualObjects(model.cards.items[index].categoryId, validCategoryId);
        }
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 1);
    XCTAssertTrue([_mockNetworkManager.receivedRequests[0] isKindOfClass:SearchRequest.class]);
    SearchRequest *request = (SearchRequest *)_mockNetworkManager.receivedRequests[0];
    XCTAssertEqualObjects(request.query[@"query"], @"validQuery");
}

- (void)testSearchShouldHandleError {
    _mockNetworkManager.behavior = ShouldReturnError;
    [_sut searchWithQuery:@"validQuery"
            andCompletion:^(SearchResultModel * _Nullable model,
                            NSString * _Nonnull query,
                            NSError * _Nullable error) {
        XCTAssertNil(model);
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.localizedDescription, @"Error occured in mocked NetworkManager!");
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 1);
    XCTAssertTrue([_mockNetworkManager.receivedRequests[0] isKindOfClass:SearchRequest.class]);
    SearchRequest *request = (SearchRequest *)_mockNetworkManager.receivedRequests[0];
    XCTAssertEqualObjects(request.query[@"query"], @"validQuery");
}

@end
