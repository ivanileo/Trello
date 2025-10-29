//
//  AccountInfoRequestTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 16.11.2021.
//

#import <XCTest/XCTest.h>

#import "AccountInfoModel.h"
#import "AccountInfoRequest.h"

@interface AccountInfoRequestTests : XCTestCase

@end

@implementation AccountInfoRequestTests

- (void)testInitWithTokenAndKeyShouldHaveSettedValues {
    AccountInfoRequest *request = [[AccountInfoRequest alloc] initWithToken:@"validToken" andKey:@"validKey"];
    XCTAssertEqual(request.requestMethod, GET);
    XCTAssertEqualObjects(request.url, @"https://api.trello.com");
    XCTAssertEqualObjects(request.path, @"/1/members/me");
    XCTAssertEqual(request.responseType, AccountInfoModel.class);
    NSDictionary<NSString *, NSString *> *validQuery = @{ @"token" : @"validToken",
                                                          @"key" : @"validKey" };
    XCTAssertEqualObjects(request.query, validQuery);
}

@end
