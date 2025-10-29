//
//  SearchView.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 13.12.2021.
//

#import <UIKit/UIKit.h>

#import "BoardContentRouter.h"
#import "SearchResultModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A delegate for SearchView for loading search results.
 */
@protocol SearchViewDelegate <NSObject>

/**
 * Performs search with specified query.
 *
 * @param searchQuery query for search.
 */
- (void)performSearchWithQuery:(NSString *)searchQuery;

@end

/**
 * A view that represents found content with search bar.
 */
@interface SearchView : UIView

/**
 * Creates search view with specific router for navigation.
 *
 * @param router BoardContentRouter for navigation.
 */
- (instancetype)initWithRouter:(BoardContentRouter *)router NS_DESIGNATED_INITIALIZER;

/**
 * Unavailable inits.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * Updates self with found model by specified search query.
 *
 * @param model search result model.
 * @param searchQuery query for search.
 */
- (void)showSearchResultWithModel:(SearchResultModel *)model andRequestedQuery:(NSString *)searchQuery;

/**
 * Actions that must be performed on viewWillAppear.
 */
- (void)handleAppearing;

/**
 * A delegate that is responsible for searching content.
 */
@property(nonatomic, weak) id<SearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
