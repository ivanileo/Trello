//
//  CardsListModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 22.11.2021.
//

#import <XCTest/XCTest.h>

#import "CardsListModel.h"

@interface CardsListModelTests : XCTestCase

@end

@implementation CardsListModelTests

- (void)testInitWithJsonShouldHaveSettedValue {
    NSArray <NSDictionary *> *array = @[ @{ @"name" : @"validName1",
                                            @"id" : @"validId1",
                                            @"idList" : @"validCategoryId1"},
                                         @{ @"name" : @"validName2",
                                            @"id" : @"validId2",
                                            @"idList" : @"validCategoryId2"}];
    CardsListModel *model = [[CardsListModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model.items);
    for (NSInteger index = 0; index < model.items.count; index++) {
        NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].name, validName);
        NSString *validCardId = [NSString stringWithFormat:@"validId%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].cardId, validCardId);
        NSString *validCategoryId = [NSString stringWithFormat:@"validCategoryId%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].categoryId, validCategoryId);
    }
}


- (void)testInitWithJsonWithNoFieldsShouldHaveArrayWithNoItems {
    NSArray <NSDictionary *> *array = @[ ];
    CardsListModel *model = [[CardsListModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model);
    XCTAssertEqual(model.items.count, 0);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    CardsListModel *model = [[CardsListModel alloc] initWithJSONObject:invalidJson];
    XCTAssertNil(model);
}

@end
