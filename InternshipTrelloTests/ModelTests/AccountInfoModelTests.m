//
//  AccountInfoModelTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 11.11.2021.
//

#import <XCTest/XCTest.h>

#import "AccountInfoModel.h"

@interface AccountInfoModelTests : XCTestCase

@end

@implementation AccountInfoModelTests

- (void)testInitWithJsonShouldHaveSettedValues {
    NSDictionary<NSString *, id> *dict = @{ @"fullName" : @"validFullName",
                                            @"username" : @"validUserName",
                                            @"initials" : @"validInitials",
                                            @"url" : @"validUrl",
                                            @"avatarUrl" : @"validAvatarUrl"};
    AccountInfoModel *model = [[AccountInfoModel alloc] initWithJSONObject:dict];

    XCTAssertEqualObjects(model.fullName, @"validFullName");
    XCTAssertEqualObjects(model.username, @"validUserName");
    XCTAssertEqualObjects(model.initials, @"validInitials");
    XCTAssertEqualObjects(model.url, @"validUrl");
    XCTAssertEqualObjects(model.avatarUrl, @"validAvatarUrl/original.png");
}

- (void)testInitWithJsonWithNoValuesShouldHaveNilValues {
    NSDictionary<NSString *, id> *dict = @{ @"fullName" : [NSNull null],
                                            @"username" : [NSNull null],
                                            @"initials" : [NSNull null],
                                            @"url" : [NSNull null],
                                            @"avatarUrl" : [NSNull null]};
    AccountInfoModel *model = [[AccountInfoModel alloc] initWithJSONObject:dict];
    
    XCTAssertNotNil(model);
    XCTAssertNil(model.fullName);
    XCTAssertNil(model.username);
    XCTAssertNil(model.initials);
    XCTAssertNil(model.url);
    XCTAssertNil(model.avatarUrl);
}

- (void)testInitWithJsonWithNoFieldsShouldHaveNilValues {
    NSDictionary<NSString *, id> *dict = @{ @"username" : @"validUserName",
                                            @"url" : @"validUrl",
                                            @"avatarUrl" : @"validAvatarUrl"};
    AccountInfoModel *model = [[AccountInfoModel alloc] initWithJSONObject:dict];
    
    XCTAssertNotNil(model);
    XCTAssertNil(model.fullName);
    XCTAssertEqualObjects(model.username, @"validUserName");
    XCTAssertNil(model.initials);
    XCTAssertEqualObjects(model.url, @"validUrl");
    XCTAssertEqualObjects(model.avatarUrl, @"validAvatarUrl/original.png");
}

- (void)testInitWithInvalidJsonShouldReturnNil {
    NSObject *invalidJson = [[NSObject alloc] init];
    AccountInfoModel *model = [[AccountInfoModel alloc] initWithJSONObject:invalidJson];
    XCTAssertNil(model);
}

@end
