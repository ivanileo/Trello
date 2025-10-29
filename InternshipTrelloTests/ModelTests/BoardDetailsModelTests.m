//
//  BoardDetailsModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 22.11.2021.
//

#import <XCTest/XCTest.h>

#import "BoardDetailsModel.h"

@interface BoardDetailsModelTests : XCTestCase

@end

@implementation BoardDetailsModelTests

- (void)testInitWithJsonShouldHaveSettedValues {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : @"validId",
                                            @"desc" : @"validDescription",
                                            @"url" : @"validUrl"};
    BoardDetailsModel *model = [[BoardDetailsModel alloc] initWithJSONObject:dict];
    
    XCTAssertEqualObjects(model.name, @"validName");
    XCTAssertEqualObjects(model.boardId, @"validId");
    XCTAssertEqualObjects(model.desc, @"validDescription");
    XCTAssertEqualObjects(model.url, @"validUrl");
}

- (void)testInitWithJsonWithNoNameShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : [NSNull null],
                                            @"id" : @"validId",
                                            @"desc" : @"validDescription",
                                            @"url" : @"validUrl"};
    BoardDetailsModel *model = [[BoardDetailsModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoUrlShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : @"validId",
                                            @"desc" : @"validDescription",
                                            @"url" : [NSNull null]};
    BoardDetailsModel *model = [[BoardDetailsModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}

- (void)testInitWithJsonWithNoIdShouldReturnNil {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : [NSNull null],
                                            @"desc" : @"validDescription",
                                            @"url" : @"validUrl"};
    BoardDetailsModel *model = [[BoardDetailsModel alloc] initWithJSONObject:dict];
    
    XCTAssertNil(model);
}


- (void)testInitWithJsonWithNoFieldsShouldHaveNilValues {
    NSDictionary<NSString *, id> *dict = @{ @"name" : @"validName",
                                            @"id" : @"validId",
                                            @"url" : @"validUrl"};
    BoardDetailsModel *model = [[BoardDetailsModel alloc] initWithJSONObject:dict];
    
    XCTAssertNotNil(model);
    XCTAssertNil(model.desc);
    
    XCTAssertEqualObjects(model.name, @"validName");
    XCTAssertEqualObjects(model.boardId, @"validId");
    XCTAssertEqualObjects(model.url, @"validUrl");
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    BoardDetailsModel *model = [[BoardDetailsModel alloc] initWithJSONObject:invalidJson];
    
    XCTAssertNil(model);
}

@end
