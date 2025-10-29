//
//  SearchRequest.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 09.12.2021.
//

#import <Foundation/Foundation.h>

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Request for searching user's boards and cards.
 */
@interface SearchRequest : BaseRequest

/** Query for searching. */
@property(nonatomic) NSString *searchQuery;

@end

NS_ASSUME_NONNULL_END
