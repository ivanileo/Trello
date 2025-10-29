//
//  MockNetworkManager.h
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 12.11.2021.
//

#import <Foundation/Foundation.h>

#import "NetworkManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A enumeration for mock of NetworkManager behavoir.
 */
typedef NS_ENUM(NSInteger, MockNetworkManagerBehavior) {
    ShouldReturnValidData,
    ShouldReturnError
};

/**
 * Mock of NetworkManager for testing.
 */
@interface MockNetworkManager : NSObject <NetworkManagerProtocol>

/**
 * Requests received by mock.
 */
@property(nonatomic, readonly) NSMutableArray *receivedRequests;

/**
 * Property for setting mock behavior.
 */
@property(nonatomic) MockNetworkManagerBehavior behavior;

@end

NS_ASSUME_NONNULL_END
