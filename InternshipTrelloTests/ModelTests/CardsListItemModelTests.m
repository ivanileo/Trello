//
//  CardsListItemModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 22.11.2021.
//

#import <XCTest/XCTest.h>

#import "CardsListItemModel.h"

@interface CardsListItemModelTests : XCTestCase

@end

@implementation CardsListItemModelTests

- (void)testInitWithJsonShouldHaveSettedValues {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : @"validId",
                                            @"idList" : @"validCategoryId"};
    CardsListItemModel *model = [[CardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertEqualObjects(model.name, @"validName");
    XCTAssertEqualObjects(model.cardId, @"validId");
    XCTAssertEqualObjects(model.categoryId, @"validCategoryId");
}

- (void)testInitWithJsonWithNoNameShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : [NSNull null],
                                            @"id" : @"validId",
                                            @"idList" : @"validCategoryId"};
    CardsListItemModel *model = [[CardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}
- (void)testInitWithJsonWithNoCategoryIdShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : @"validId",
                                            @"idList" : [NSNull null]};
    CardsListItemModel *model = [[CardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoIdShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : [NSNull null],
                                            @"idList" : @"validCategoryId"};
    CardsListItemModel *model = [[CardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoFieldsShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"id" : @"validId" };
    CardsListItemModel *model = [[CardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    CardsListItemModel *model = [[CardsListItemModel alloc] initWithJSONObject:invalidJson];
    
    XCTAssertNil(model);
}

@end
