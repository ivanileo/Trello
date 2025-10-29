//
//  ActionsListRequest.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.12.2021.
//

#import <Foundation/Foundation.h>

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Request for fetching user's actions list.
 */
@interface ActionsListRequest : BaseRequest <NetworkRequest>

/** Set this property to specify upper bound to returned list. */
@property(nonatomic, nullable) NSString *beforeId;

/** Max number of returned actions. */
@property(nonatomic) NSUInteger limit;

@end

NS_ASSUME_NONNULL_END
