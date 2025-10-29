//
//  AccountService.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 26.10.2021.
//

#import <Foundation/Foundation.h>

#import "AccountInfoModel.h"
#import "AccountInfoRequest.h"
#import "InternshipTrello-Swift.h"
#import "NetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

/** Type of completion block for handling account info model result. */
typedef void (^AccountInfoCompletion)(AccountInfoModel * _Nullable,  NSError * _Nullable);

/** Type of completion block for handling authorization result. */
typedef void (^AuthorizationCompletion)(BOOL,  NSError * _Nullable);

/**
 * Performs actions with user account.
 */
@interface AccountService : NSObject

extern NSString *const kLogoutNotification;

/**
 * Creates instance with specific NetworkManager and AuthorizationService objects.
 *
 * @param networkManager object that conforms NetworkManagerProtocol protocol.
 * @param authorizationService object that conforms AuthorizationServiceProtocol protocol.
 */
- (instancetype)initWithNetworkManager:(id<NetworkManagerProtocol>)networkManager
               andAuthorizationService:(id<AuthorizationServiceProtocol>)authorizationService;

/**
 * Returns account information or error in completion block.
 *
 * @param completion completion block to handle result or error.
 */
- (void)getAccountInfoWithCompletion:(AccountInfoCompletion)completion;

/**
 * Performs actions for log out from account.
 */
- (void)performLogout;

/**
 * Performs authorization.
 *
 * @param completion completion block to handle authorization result or error.
 */
- (void)authorizeWithCompletion:(AuthorizationCompletion)completion;

/**
 * Shows if user authorized or not.
 */
- (BOOL)isAuthorized;

@end

NS_ASSUME_NONNULL_END
