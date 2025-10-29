//
//  BoardsListItemModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 11.11.2021.
//

#import <XCTest/XCTest.h>

#import "BoardsListItemModel.h"

@interface BoardsListItemModelTests : XCTestCase

@end

@implementation BoardsListItemModelTests

- (void)testInitWithJsonShouldHaveSettedValues {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : @"validId",
                                            @"prefs" : @{@"backgroundImage" : @"validBackgroundImage"}};
    BoardsListItemModel *model = [[BoardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertEqualObjects(model.name, @"validName");
    XCTAssertEqualObjects(model.boardId, @"validId");
    XCTAssertEqualObjects(model.imageUrl, @"validBackgroundImage");
}

- (void)testInitWithJsonWithNoValuesShouldHaveNilValues {
    NSDictionary<NSString *, id> *dict = @{ @"name" : [NSNull null],
                                            @"id" : @"validId",
                                            @"prefs" : @{@"backgroundImage" : [NSNull null]}};
    BoardsListItemModel *model = [[BoardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNotNil(model);
    XCTAssertNil(model.imageUrl);
    XCTAssertNil(model.name);
}

- (void)testInitWithJsonWithNoFieldsShouldHaveNilValues {
    NSDictionary<NSString *, id> *dict = @{ @"id" : @"validId" };
    BoardsListItemModel *model = [[BoardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNotNil(model);
    XCTAssertNil(model.imageUrl);
    XCTAssertNil(model.name);
}

- (void)testInitWithJsonWithNoIdShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : [NSNull null],
                                            @"prefs" : @{@"backgroundImage" : [NSNull null]}};
    BoardsListItemModel *model = [[BoardsListItemModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    BoardsListItemModel *model = [[BoardsListItemModel alloc] initWithJSONObject:invalidJson];
    
    XCTAssertNil(model);
}

@end
