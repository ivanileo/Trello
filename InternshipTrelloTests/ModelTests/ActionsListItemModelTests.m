//
//  ActionsListItemModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 06.12.2021.
//

#import <XCTest/XCTest.h>

#import "ActionsListItemModel.h"

@interface ActionsListItemModelTests : XCTestCase

@end

@implementation ActionsListItemModelTests

- (void)testInitWithJsonShouldHaveSettedValues {
    NSDictionary<NSString *, id> *dict = @{ @"id" : @"validId",
                                            @"type" : @"validType",
                                            @"date" : @"validDate",
                                            @"memberCreator" : @{
                                                @"username" : @"validUsername" } };
    ActionsListItemModel *model = [[ActionsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertEqualObjects(model.actionId, @"validId");
    XCTAssertEqualObjects(model.date, @"validDate");
    XCTAssertEqualObjects(model.type, @"validType");
    XCTAssertEqualObjects(model.username, @"validUsername");
}

- (void)testInitWithJsonWithNoDateShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"id" : @"validId",
                                            @"type" : @"validType",
                                            @"date" : [NSNull null],
                                            @"memberCreator" : @{
                                                @"username" : @"validUsername" } };
    ActionsListItemModel *model = [[ActionsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoTypeShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"id" : @"validId",
                                            @"type" : [NSNull null],
                                            @"date" : @"validDate",
                                            @"memberCreator" : @{
                                                @"username" : @"validUsername" } };
    ActionsListItemModel *model = [[ActionsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoIdShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"id" : [NSNull null],
                                            @"type" : @"validType",
                                            @"date" : @"validDate",
                                            @"memberCreator" : @{
                                                @"username" : @"validUsername" } };
    ActionsListItemModel *model = [[ActionsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoUsernameShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"id" : @"validId",
                                            @"type" : @"validType",
                                            @"date" : @"validDate",
                                            @"memberCreator" : @{
                                                @"username" : [NSNull null] } };
    ActionsListItemModel *model = [[ActionsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoFieldsShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"id" : @"validId" };
    ActionsListItemModel *model = [[ActionsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    ActionsListItemModel *model = [[ActionsListItemModel alloc] initWithJSONObject:invalidJson];
    
    XCTAssertNil(model);
}

@end
