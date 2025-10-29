//
//  NetworkManagerProtocol.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 12.11.2021.
//

#import <Foundation/Foundation.h>

#import "NetworkRequest.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Type of completion block for response.
 */
typedef void (^RequestCompletion)(_Nullable id<SerializableModel>,  NSError * _Nullable);

@protocol NetworkManagerProtocol <NSObject>

/**
 * Sends request and handle response using completion block.
 *
 * @param request NetworkRequest object with all required information.
 * @param completion completion block that handles response.
 */
- (void)sendRequest:(id<NetworkRequest>)request
     withCompletion:(RequestCompletion)completion;

@end

NS_ASSUME_NONNULL_END
