//
//  CategoriesListItemModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 22.11.2021.
//

#import <XCTest/XCTest.h>

#import "CategoriesListItemModel.h"

@interface CategoriesListItemModelTests : XCTestCase

@end

@implementation CategoriesListItemModelTests

- (void)testInitWithJsonShouldHaveSettedValues {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : @"validId" };
    CategoriesListItemModel *model = [[CategoriesListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertEqualObjects(model.name, @"validName");
    XCTAssertEqualObjects(model.categoryId, @"validId");
}

- (void)testInitWithJsonWithNoNameShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : [NSNull null],
                                            @"id" : @"validId"};
    CategoriesListItemModel *model = [[CategoriesListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoIdShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : [NSNull null]};
    CategoriesListItemModel *model = [[CategoriesListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoFieldsShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"id" : @"validId" };
    CategoriesListItemModel *model = [[CategoriesListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    CategoriesListItemModel *model = [[CategoriesListItemModel alloc] initWithJSONObject:invalidJson];
    
    XCTAssertNil(model);
}

@end
