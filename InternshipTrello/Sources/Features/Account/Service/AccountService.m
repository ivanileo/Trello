//
//  AccountService.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 26.10.2021.
//

#import "AccountService.h"

NS_ASSUME_NONNULL_BEGIN

/** Error domain const.*/
static NSString *const kAccountServiceErrorDomain = @"AccountServiceErrorDomain";

/** Account service errors.*/
typedef NS_ENUM(NSInteger, AccountServiceErrorCode) {
    AccountServiceErrorCodeUnexpectedModel = 1
};

@implementation AccountService {
    id<NetworkManagerProtocol> _networkManager;
    id<AuthorizationServiceProtocol> _authorizationService;
}

/** Notifications consts. */
NSString *const kLogoutNotification = @"LogoutNotification";

- (instancetype)init {
    return [self initWithNetworkManager:NetworkManager.shared
                andAuthorizationService:[[AuthorizationService alloc] init]];
}

- (instancetype)initWithNetworkManager:(id<NetworkManagerProtocol>)networkManager
               andAuthorizationService:(id<AuthorizationServiceProtocol>)authorizationService {
    self = [super init];
    if (self) {
        _authorizationService = authorizationService;
        _networkManager = networkManager;
    }
    return self;
}

- (void)getAccountInfoWithCompletion:(AccountInfoCompletion)completion {
    AccountInfoRequest *request = [[AccountInfoRequest alloc] init];
    [_networkManager sendRequest:request
                  withCompletion:^(id<SerializableModel> _Nullable model, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            completion(nil, error);
            return;
        }
        completion(model, nil);
    }];
}

- (void)performLogout {
    [_authorizationService logout];
    [NSNotificationCenter.defaultCenter postNotificationName:kLogoutNotification
                                                      object:self];
}

- (void)authorizeWithCompletion:(AuthorizationCompletion)completion {
    [_authorizationService authorizeWithCompletion:completion];
}

- (BOOL)isAuthorized {
    return [[_authorizationService class] isAuthorized];
}

@end

NS_ASSUME_NONNULL_END
