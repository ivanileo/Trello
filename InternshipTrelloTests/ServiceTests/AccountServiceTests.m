//
//  AccountServiceTests.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 12.11.2021.
//

#import <XCTest/XCTest.h>

#import "AccountInfoRequest.h"
#import "AccountService.h"
#import "MockAuthorizationService.h"
#import "MockNetworkManager.h"

@interface AccountServiceTests : XCTestCase

@end

@implementation AccountServiceTests {
    AccountService *_sut;
    MockNetworkManager *_mockNetworkManager;
    MockAuthorizationService *_mockAuthorizationService;
}

- (void)setUp {
    _mockNetworkManager = [[MockNetworkManager alloc] init];
    _mockAuthorizationService = [[MockAuthorizationService alloc] init];
    _mockAuthorizationService.authorized = NO;
    _sut = [[AccountService alloc] initWithNetworkManager:_mockNetworkManager
                                  andAuthorizationService:_mockAuthorizationService];
}

- (void)tearDown {
    _mockNetworkManager = nil;
    _mockAuthorizationService = nil;
    _sut = nil;
}

- (void)testGetAccountInfoShouldHandleValidModel {
    _mockNetworkManager.behavior = ShouldReturnValidData;
    [_sut getAccountInfoWithCompletion:^(AccountInfoModel * _Nullable model,
                                         NSError * _Nullable error) {
        XCTAssertNotNil(model);
        XCTAssertEqual(model.class, AccountInfoModel.class);
        XCTAssertNil(error);
        XCTAssertEqualObjects(model.avatarUrl, @"validAvatarUrl/original.png");
        XCTAssertEqualObjects(model.url, @"validUrl");
        XCTAssertEqualObjects(model.fullName, @"validFullName");
        XCTAssertEqualObjects(model.username, @"validUserName");
        XCTAssertEqualObjects(model.initials, @"validInitials");
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 1);
    XCTAssertTrue([_mockNetworkManager.receivedRequests[0] isKindOfClass:AccountInfoRequest.class]);
}

- (void)testGetAccountInfoShouldHandleError {
    _mockNetworkManager.behavior = ShouldReturnError;
    [_sut getAccountInfoWithCompletion:^(AccountInfoModel * _Nullable model,
                                         NSError * _Nullable error) {
        XCTAssertNil(model);
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.localizedDescription, @"Error occured in mocked NetworkManager!");
    }];
    XCTAssertEqual(_mockNetworkManager.receivedRequests.count, 1);
    XCTAssertTrue([_mockNetworkManager.receivedRequests[0] isKindOfClass:AccountInfoRequest.class]);
}

- (void)testAuthorizeAuthorizationServiceShouldBeAuthorized {
    _mockAuthorizationService.authorized = NO;
    [_sut authorizeWithCompletion:^(BOOL isAuthorize, NSError * _Nullable error) {
        XCTAssertTrue(isAuthorize);
    }];
    XCTAssertTrue(_sut.isAuthorized);
}

- (void)testPerformLogoutShouldSetIsAuthorizedFromTrueToFalse {
    _mockAuthorizationService.authorized = YES;
    [_sut performLogout];
    XCTAssertFalse(_sut.isAuthorized);
}

@end
