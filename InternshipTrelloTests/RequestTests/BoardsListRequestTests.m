//
//  BoardsListRequestTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 16.11.2021.
//

#import <XCTest/XCTest.h>

#import "BoardsListModel.h"
#import "BoardsListRequest.h"

@interface BoardsListRequestTests : XCTestCase

@end

@implementation BoardsListRequestTests

- (void)testInitWithTokenAndKeyShouldHaveSettedValues {
    BoardsListRequest *request = [[BoardsListRequest alloc] initWithToken:@"validToken" andKey:@"validKey"];
    XCTAssertEqual(request.requestMethod, GET);
    XCTAssertEqualObjects(request.url, @"https://api.trello.com");
    XCTAssertEqualObjects(request.path, @"/1/members/me/boards");
    XCTAssertEqual(request.responseType, BoardsListModel.class);
    NSDictionary<NSString *, NSString *> *validQuery = @{ @"token" : @"validToken",
                                                          @"key" : @"validKey" };
    XCTAssertEqualObjects(request.query, validQuery);
}

@end
