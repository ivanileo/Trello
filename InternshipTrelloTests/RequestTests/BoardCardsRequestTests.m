//
//  BoardCardsRequestTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 22.11.2021.
//

#import <XCTest/XCTest.h>

#import "BoardCardsRequest.h"
#import "CardsListModel.h"

@interface BoardCardsRequestTests : XCTestCase

@end

@implementation BoardCardsRequestTests

- (void)testInitWithTokenAndKeyShouldHaveSettedValues {
    BoardCardsRequest *request = [[BoardCardsRequest alloc] initWithToken:@"validToken" andKey:@"validKey"];
    request.boardId = @"validBoardId";
    
    XCTAssertEqual(request.requestMethod, GET);
    XCTAssertEqualObjects(request.url, @"https://api.trello.com");
    XCTAssertEqualObjects(request.path, @"/1/boards/validBoardId/cards");
    XCTAssertEqual(request.responseType, CardsListModel.class);
    NSDictionary<NSString *, NSString *> *validQuery = @{ @"token" : @"validToken",
                                                          @"key" : @"validKey" };
    XCTAssertEqualObjects(request.query, validQuery);
}

@end
