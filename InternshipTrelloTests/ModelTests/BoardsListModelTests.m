//
//  BoardsListModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 11.11.2021.
//

#import <XCTest/XCTest.h>

#import "BoardsListModel.h"

@interface BoardsListModelTests : XCTestCase

@end

@implementation BoardsListModelTests

- (void)testInitWithJsonShouldHaveSettedValue {
    NSArray <NSDictionary *> *array = @[ @{ @"name" : @"validName1",
                                            @"id" : @"validId1",
                                            @"prefs" : @{@"backgroundImage" : @"validBackgroundImage1"}},
                                         @{ @"name" : @"validName2",
                                            @"id" : @"validId2",
                                            @"prefs" : @{@"backgroundImage" : @"validBackgroundImage2"}}];
    BoardsListModel *model = [[BoardsListModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model.items);
    for (NSInteger index = 0; index < model.items.count; index++) {
        NSString *validName = [NSString stringWithFormat:@"validName%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].name, validName);
        NSString *validId = [NSString stringWithFormat:@"validId%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].boardId, validId);
        NSString *validImage = [NSString stringWithFormat:@"validBackgroundImage%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].imageUrl, validImage);
    }
}

- (void)testInitWithJsonWithNoFieldsShouldHaveArrayWithNoItems {
    NSArray <NSDictionary *> *array = @[ ];
    BoardsListModel *model = [[BoardsListModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model);
    XCTAssertEqual(model.items.count, 0);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    BoardsListModel *model = [[BoardsListModel alloc] initWithJSONObject:invalidJson];
    XCTAssertNil(model);
}

@end
