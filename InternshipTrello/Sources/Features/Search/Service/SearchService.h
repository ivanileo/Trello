//
//  SearchService.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 09.12.2021.
//

#import <Foundation/Foundation.h>

#import "NetworkManagerProtocol.h"
#import "SearchResultModel.h"

NS_ASSUME_NONNULL_BEGIN

/** Type of completion block for handling search result. */
typedef void (^SearchResultCompletion)(SearchResultModel * _Nullable, NSString *query,  NSError * _Nullable);

/**
 * Performs actions for searching through user's cards and boards to show.
 */
@interface SearchService : NSObject

/**
 * Creates SearchService with specific NetworkNamagerProtocol object.
 *
 * @param networkManager object that conforms protocol NetworkManagerProtocol.
 */
- (instancetype)initWithNetworkManager:(id<NetworkManagerProtocol>)networkManager;

/**
 * Returns list of search results for current user or error in completion block.
 * Also returns search query in completion block.
 *
 * @param query search query. 
 * @param completion completion block to handle result or error.
 */
- (void)searchWithQuery:(NSString *)query andCompletion:(SearchResultCompletion)completion;

@end

NS_ASSUME_NONNULL_END
