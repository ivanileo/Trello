//
//  BoardDetailsRequestTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 22.11.2021.
//

#import <XCTest/XCTest.h>

#import "BoardDetailsRequest.h"
#import "BoardDetailsModel.h"

@interface BoardDetailsRequestTests : XCTestCase

@end

@implementation BoardDetailsRequestTests

- (void)testInitWithTokenAndKeyShouldHaveSettedValues {
    BoardDetailsRequest *request = [[BoardDetailsRequest alloc] initWithToken:@"validToken" andKey:@"validKey"];
    request.boardId = @"validBoardId";
    
    XCTAssertEqual(request.requestMethod, GET);
    XCTAssertEqualObjects(request.url, @"https://api.trello.com");
    XCTAssertEqualObjects(request.path, @"/1/boards/validBoardId");
    XCTAssertEqual(request.responseType, BoardDetailsModel.class);
    NSDictionary<NSString *, NSString *> *validQuery = @{ @"token" : @"validToken",
                                                          @"key" : @"validKey" };
    XCTAssertEqualObjects(request.query, validQuery);
}

@end
