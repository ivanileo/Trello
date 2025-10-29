//
//  MockAuthorizationService.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 12.11.2021.
//

#import "MockAuthorizationService.h"

NS_ASSUME_NONNULL_BEGIN

static BOOL kIsAuthorized = NO;

@implementation MockAuthorizationService

- (void)authorizeWithCompletion:(void (^ _Nonnull)(BOOL, NSError * _Nullable))completion {
    [self.class setAuthorized:YES];
    completion(YES, nil);
}

- (void)logout {
    [self.class setAuthorized:NO];
}

- (BOOL)isAuthorized {
    return [self.class isAuthorized];
}

- (void)authorized:(BOOL)isAuthorized {
    [self.class setAuthorized:isAuthorized];
}

+ (BOOL)isAuthorized {
    return kIsAuthorized;
}

+ (void)setAuthorized:(BOOL)isAuthorized {
    kIsAuthorized = isAuthorized;
}

@end

NS_ASSUME_NONNULL_END
