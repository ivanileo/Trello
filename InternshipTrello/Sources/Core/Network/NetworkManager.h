//
//  NetworkManager.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 21.10.2021.
//

#import <Foundation/Foundation.h>

#import "NetworkManagerProtocol.h"
#import "NetworkRequest.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Performs actions with network.
 */
@interface NetworkManager : NSObject <NetworkManagerProtocol>

/**
 * Returns shared singleton object of NetworkManager.
 */
+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
