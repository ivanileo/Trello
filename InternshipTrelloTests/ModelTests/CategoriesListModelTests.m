//
//  CategoriesListModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 22.11.2021.
//

#import <XCTest/XCTest.h>

#import "CategoriesListModel.h"

@interface CategoriesListModelTests : XCTestCase

@end

@implementation CategoriesListModelTests

- (void)testInitWithJsonShouldHaveSettedValue {
    NSArray <NSDictionary *> *array = @[ @{ @"name" : @"validName1",
                                            @"id" : @"validId1"},
                                         @{ @"name" : @"validName2",
                                            @"id" : @"validId2"}];
    CategoriesListModel *model = [[CategoriesListModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model.items);
    for (NSInteger index = 0; index < model.items.count; index++) {
        NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].name, validName);
        NSString *validCategoryId = [NSString stringWithFormat:@"validId%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].categoryId, validCategoryId);
    }
}


- (void)testInitWithJsonWithNoFieldsShouldHaveArrayWithNoItems {
    NSArray <NSDictionary *> *array = @[ ];
    CategoriesListModel *model = [[CategoriesListModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model);
    XCTAssertEqual(model.items.count, 0);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    CategoriesListModel *model = [[CategoriesListModel alloc] initWithJSONObject:invalidJson];
    XCTAssertNil(model);
}

@end
