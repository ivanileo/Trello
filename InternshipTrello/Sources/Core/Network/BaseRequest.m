//
//  BaseRequest.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.10.2021.
//

#import "BaseRequest.h"
#import "KeychainService.h"
#import "PlistManager.h"

NS_ASSUME_NONNULL_BEGIN

/** URLs. */
static NSString *const kBaseURL = @"https://api.trello.com";

/** Plist names consts. */
static NSString *const kWebConfigPlistName = @"WebConfig";
static NSString *const kBaseUrlPlistKey = @"BaseURL";
static NSString *const kDevAPIKeyPlistKey = @"DevAPIKey";

/** URL params key consts. */
static NSString *const kTokenKey = @"token";
static NSString *const kDevAPIKey = @"key";

/** Keychain consts. */
static NSString *const kTokenKeychainKey = @"DefaultUserOAuthToken";

@implementation BaseRequest {
    NSString *_token;
    NSString *_key;
}

- (instancetype)initWithToken:(nullable NSString *)token andKey:(nullable NSString *)key {
    self = [super init];
    if (self) {
        _token = token;
        _key = key;
    }
    return self;
}

- (NSString *)url {
    return kBaseURL;
}

- (nullable NSString *)path {
    return nil;
}

- (nullable NSData *)body {
    return nil;
}

- (nullable NSDictionary<NSString *, NSString *> *)query {
    NSString *returnedToken = _token ?: [KeychainService stringValueByKey:kTokenKeychainKey];
    NSString *returnedKey = _key ?: [PlistManager stringValueByPlistName:kWebConfigPlistName
                                                                  andKey:kDevAPIKeyPlistKey];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if (returnedToken) {
        result[kTokenKey] = returnedToken;
    }
    if (returnedKey) {
        result[kDevAPIKey] = returnedKey;
    }
    return result;
}

- (nullable NSDictionary<NSString *, NSString *> *)headers {
    return nil;
}

- (HTTPMethod)requestMethod {
    [self doesNotRecognizeSelector:_cmd];
    return GET;
}

- (nullable Class)responseType {
    return nil;
}

@end

NS_ASSUME_NONNULL_END
