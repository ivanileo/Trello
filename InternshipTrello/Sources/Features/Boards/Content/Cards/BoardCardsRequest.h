//
//  BoardCardsRequest.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "BoardDetailsRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Request for fetching cards on board.
 */
@interface BoardCardsRequest : BoardDetailsRequest <NetworkRequest>

@end

NS_ASSUME_NONNULL_END
