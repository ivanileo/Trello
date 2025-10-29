//
//  ActionsListRequestTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 06.12.2021.
//

#import <XCTest/XCTest.h>

#import "ActionsListModel.h"
#import "ActionsListRequest.h"

@interface ActionsListRequestTests : XCTestCase

@end

@implementation ActionsListRequestTests

- (void)testInitWithTokenAndKeyShouldHaveSettedValues {
    ActionsListRequest *request = [[ActionsListRequest alloc] initWithToken:@"validToken" andKey:@"validKey"];
    request.limit = 20;
    request.beforeId = @"validBeforeId";
    
    XCTAssertEqual(request.requestMethod, GET);
    XCTAssertEqualObjects(request.url, @"https://api.trello.com");
    XCTAssertEqualObjects(request.path, @"/1/members/me/actions");
    XCTAssertEqual(request.responseType, ActionsListModel.class);
    NSDictionary<NSString *, NSString *> *validQuery = @{ @"token" : @"validToken",
                                                          @"key" : @"validKey",
                                                          @"limit" : @"20",
                                                          @"before" : @"validBeforeId" };
    XCTAssertEqualObjects(request.query, validQuery);
}

@end
