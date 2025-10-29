//
//  SearchResultModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 13.12.2021.
//

#import <XCTest/XCTest.h>

#import "BoardsListModel.h"
#import "CardsListModel.h"
#import "SearchResultModel.h"

@interface SearchResultModelTests : XCTestCase

@end

@implementation SearchResultModelTests

- (void)testInitWithJsonShouldHaveSettedValue {
    NSDictionary *array = @{ @"cards": @[ @{ @"name" : @"validName1",
                                             @"id" : @"validId1",
                                             @"idList" : @"validCategoryId1"},
                                          @{ @"name" : @"validName2",
                                             @"id" : @"validId2",
                                             @"idList" : @"validCategoryId2"} ],
                             @"boards": @[ @{ @"name" : @"validName1",
                                              @"id" : @"validId1",
                                              @"prefs" : @{@"backgroundImage" : @"validBackgroundImage1"}},
                                           @{ @"name" : @"validName2",
                                              @"id" : @"validId2",
                                              @"prefs" : @{@"backgroundImage" : @"validBackgroundImage2"}} ] };
    SearchResultModel *model = [[SearchResultModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model.cards.items);
    XCTAssertNotNil(model.boards.items);
    for (NSInteger index = 0; index < model.cards.items.count; index++) {
        NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
        XCTAssertEqualObjects(model.cards.items[index].name, validName);
        NSString *validCardId = [NSString stringWithFormat:@"validId%ld", index + 1];
        XCTAssertEqualObjects(model.cards.items[index].cardId, validCardId);
        NSString *validCategoryId = [NSString stringWithFormat:@"validCategoryId%ld", index + 1];
        XCTAssertEqualObjects(model.cards.items[index].categoryId, validCategoryId);
    }
    for (NSInteger index = 0; index < model.boards.items.count; index++) {
        NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
        XCTAssertEqualObjects(model.boards.items[index].name, validName);
        NSString *validId = [NSString stringWithFormat:@"validId%ld", index + 1];
        XCTAssertEqualObjects(model.boards.items[index].boardId, validId);
        NSString *validImage = [NSString stringWithFormat:@"validBackgroundImage%ld", index + 1];
        XCTAssertEqualObjects(model.boards.items[index].imageUrl, validImage);
    }
}

- (void)testInitWithJsonWithNoBoardsShouldHaveSettedValue {
    NSDictionary *array = @{ @"cards": @[ @{ @"name" : @"validName1",
                                             @"id" : @"validId1",
                                             @"idList" : @"validCategoryId1"},
                                          @{ @"name" : @"validName2",
                                             @"id" : @"validId2",
                                             @"idList" : @"validCategoryId2"} ] };
    SearchResultModel *model = [[SearchResultModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model.cards.items);
    XCTAssertNil(model.boards.items);
    for (NSInteger index = 0; index < model.cards.items.count; index++) {
        NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
        XCTAssertEqualObjects(model.cards.items[index].name, validName);
        NSString *validCardId = [NSString stringWithFormat:@"validId%ld", index + 1];
        XCTAssertEqualObjects(model.cards.items[index].cardId, validCardId);
        NSString *validCategoryId = [NSString stringWithFormat:@"validCategoryId%ld", index + 1];
        XCTAssertEqualObjects(model.cards.items[index].categoryId, validCategoryId);
    }
}

- (void)testInitWithJsonWithNoCardsShouldHaveSettedValue {
    NSDictionary *array = @{ @"boards": @[ @{ @"name" : @"validName1",
                                              @"id" : @"validId1",
                                              @"prefs" : @{@"backgroundImage" : @"validBackgroundImage1"}},
                                           @{ @"name" : @"validName2",
                                              @"id" : @"validId2",
                                              @"prefs" : @{@"backgroundImage" : @"validBackgroundImage2"}} ] };
    SearchResultModel *model = [[SearchResultModel alloc] initWithJSONObject:array];
    XCTAssertNil(model.cards.items);
    XCTAssertNotNil(model.boards.items);
    for (NSInteger index = 0; index < model.boards.items.count; index++) {
        NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
        XCTAssertEqualObjects(model.boards.items[index].name, validName);
        NSString *validId = [NSString stringWithFormat:@"validId%ld", index + 1];
        XCTAssertEqualObjects(model.boards.items[index].boardId, validId);
        NSString *validImage = [NSString stringWithFormat:@"validBackgroundImage%ld", index + 1];
        XCTAssertEqualObjects(model.boards.items[index].imageUrl, validImage);
    }
}

- (void)testInitWithJsonWithNoFieldsShouldHaveArrayWithNoItems {
    NSDictionary *array = @{ };
    SearchResultModel *model = [[SearchResultModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model);
    XCTAssertEqual(model.cards.items.count, 0);
    XCTAssertEqual(model.boards.items.count, 0);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    SearchResultModel *model = [[SearchResultModel alloc] initWithJSONObject:invalidJson];
    XCTAssertNil(model);
}

@end
