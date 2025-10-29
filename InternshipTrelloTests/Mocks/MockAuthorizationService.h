//
//  MockAuthorizationService.h
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 12.11.2021.
//

#import <Foundation/Foundation.h>

#import "InternshipTrello-Swift.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Mock of AuthorizationService for testing.
 */
@interface MockAuthorizationService : NSObject <AuthorizationServiceProtocol>

/**
 * Shows if user is authorized or not.
 */
@property(class, nonatomic, getter=isAuthorized) BOOL authorized;

@property(nonatomic, getter=isAuthorized) BOOL authorized;

@end

NS_ASSUME_NONNULL_END
