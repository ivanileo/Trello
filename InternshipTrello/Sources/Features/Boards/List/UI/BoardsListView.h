//
//  BoardsListView.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 08.11.2021.
//

#import <UIKit/UIKit.h>

#import "BoardsListModel.h"
#import "BoardContentRouter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A delegate for BoardsListView to handle refreshing data.
 */
@protocol BoardsListViewDelegate <NSObject>

/**
 * Reloads list of user's boards.
 */
- (void)boardsListViewShouldRefreshData;

@end

/**
 * A view that represents list with user's boards.
 */
@interface BoardsListView : UIView

/**
 * Creates view with specific BoardContentRouter router.
 *
 * @param router BoardContentRouter for navigation.
 */
- (instancetype)initWithRouter:(BoardContentRouter *)router;

/**
 * Reloads boards to show actual list.
 *
 * @param model model with user's boards.
 */
- (void)reloadWithModel:(nullable BoardsListModel *)model;

/**
 * A delegate that is responsible for refreshing boards list.
 */
@property(nonatomic, weak) id<BoardsListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
