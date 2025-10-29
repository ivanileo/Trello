//
//  ActionsListModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 06.12.2021.
//

#import <XCTest/XCTest.h>

#import "ActionsListModel.h"

@interface ActionsListModelTests : XCTestCase

@end

@implementation ActionsListModelTests

- (void)testInitWithJsonShouldHaveSettedValue {
    NSArray <NSDictionary *> *array = @[ @{ @"id" : @"validId1",
                                            @"type" : @"validType1",
                                            @"date" : @"validDate1",
                                            @"memberCreator" : @{
                                                @"username" : @"validUsername1" } },
                                         @{ @"id" : @"validId2",
                                            @"type" : @"validType2",
                                            @"date" : @"validDate2",
                                            @"memberCreator" : @{
                                                @"username" : @"validUsername2" } }];
    ActionsListModel *model = [[ActionsListModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model.items);
    for (NSInteger index = 0; index < model.items.count; index++) {
        NSString *validActionId = [NSString stringWithFormat:@"validId%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].actionId, validActionId);
        NSString *validType = [NSString stringWithFormat:@"validType%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].type, validType);
        NSString *validDate = [NSString stringWithFormat:@"validDate%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].date, validDate);
        NSString *validUsername = [NSString stringWithFormat:@"validUsername%ld", index + 1];
        XCTAssertEqualObjects(model.items[index].username, validUsername);
    }
}


- (void)testInitWithJsonWithNoFieldsShouldHaveArrayWithNoItems {
    NSArray <NSDictionary *> *array = @[ ];
    ActionsListModel *model = [[ActionsListModel alloc] initWithJSONObject:array];
    XCTAssertNotNil(model);
    XCTAssertEqual(model.items.count, 0);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    ActionsListModel *model = [[ActionsListModel alloc] initWithJSONObject:invalidJson];
    XCTAssertNil(model);
}

@end
