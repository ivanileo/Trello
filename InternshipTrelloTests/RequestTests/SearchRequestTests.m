//
//  SearchRequestTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 13.12.2021.
//

#import <XCTest/XCTest.h>

#import "SearchRequest.h"
#import "SearchResultModel.h"

@interface SearchRequestTests : XCTestCase

@end

@implementation SearchRequestTests

- (void)testInitWithTokenAndKeyShouldHaveSettedValues {
    SearchRequest *request = [[SearchRequest alloc] initWithToken:@"validToken" andKey:@"validKey"];
    request.searchQuery = @"validSearchQuery";
    
    XCTAssertEqual(request.requestMethod, GET);
    XCTAssertEqualObjects(request.url, @"https://api.trello.com");
    XCTAssertEqualObjects(request.path, @"/1/search");
    XCTAssertEqual(request.responseType, SearchResultModel.class);
    NSDictionary<NSString *, NSString *> *validQuery = @{ @"token" : @"validToken",
                                                          @"key" : @"validKey",
                                                          @"query" : @"validSearchQuery",
                                                          @"partial" : @"true" };
    XCTAssertEqualObjects(request.query, validQuery);

}

@end
