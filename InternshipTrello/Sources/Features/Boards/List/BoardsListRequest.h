//
//  BoardsListRequest.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 05.11.2021.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Request for fetching user's boards list.
 */
@interface BoardsListRequest : BaseRequest <NetworkRequest>

@end

NS_ASSUME_NONNULL_END
