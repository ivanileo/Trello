//
//  BoardCategoriesRequestTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 22.11.2021.
//

#import <XCTest/XCTest.h>

#import "BoardCategoriesRequest.h"
#import "CategoriesListModel.h"

@interface BoardCategoriesRequestTests : XCTestCase

@end

@implementation BoardCategoriesRequestTests

- (void)testInitWithTokenAndKeyShouldHaveSettedValues {
    BoardCategoriesRequest *request = [[BoardCategoriesRequest alloc] initWithToken:@"validToken" andKey:@"validKey"];
    request.boardId = @"validBoardId";
    
    XCTAssertEqual(request.requestMethod, GET);
    XCTAssertEqualObjects(request.url, @"https://api.trello.com");
    XCTAssertEqualObjects(request.path, @"/1/boards/validBoardId/lists");
    XCTAssertEqual(request.responseType, CategoriesListModel.class);
    NSDictionary<NSString *, NSString *> *validQuery = @{ @"token" : @"validToken",
                                                          @"key" : @"validKey" };
    XCTAssertEqualObjects(request.query, validQuery);
}

@end
