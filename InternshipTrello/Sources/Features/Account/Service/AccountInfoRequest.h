//
//  AccountRequest.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.10.2021.
//

#import <Foundation/Foundation.h>

#import "BaseRequest.h"
#import "NetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Request for fetching user account information.
 */
@interface AccountInfoRequest : BaseRequest <NetworkRequest>

@end

NS_ASSUME_NONNULL_END
