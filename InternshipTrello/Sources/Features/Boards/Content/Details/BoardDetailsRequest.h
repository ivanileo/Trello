//
//  BoardDetailsRequest.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 18.11.2021.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Request for fetching board details.
 */
@interface BoardDetailsRequest : BaseRequest <NetworkRequest>

/** Id of board. */
@property(nonatomic, nullable) NSString *boardId;

@end

NS_ASSUME_NONNULL_END
