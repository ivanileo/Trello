//
//  BaseRequest.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.10.2021.
//

#import <Foundation/Foundation.h>

#import "NetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A class that can be basis for diffirent classes that conform NetworkRequest protocol.
 */
@interface BaseRequest : NSObject <NetworkRequest>

/**
 * Creates request with specific token and devAPI key.
 * If nil values passed through arguments, value from keychain will be used
 * for token and value from plist with configuration for devAPI key.
 *
 * @param token token for request.
 * @param key devAPI key for request.
 */
- (instancetype)initWithToken:(nullable NSString *)token andKey:(nullable NSString *)key;

@end

NS_ASSUME_NONNULL_END
