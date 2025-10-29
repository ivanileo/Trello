//
//  ActionsListView.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 07.12.2021.
//

#import <UIKit/UIKit.h>

#import "ActionsListModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A delegate for ActionsListView to loading data.
 */
@protocol ActionsListViewDelegate <NSObject>

/**
 * Appends list of user's boards.
 *
 * @param beforeId last action that was displayed in list. Used for pagination.
 */
- (void)updateViewWithBeforeId:(nullable NSString *)beforeId;

@end

@interface ActionsListView : UIView

/**
 * Reloads actions to show actual list.
 *
 * @param model model with user's actions.
 */
- (void)reloadWithModel:(nullable ActionsListModel *)model;

/**
 * Apennds actions to show list.
 *
 * @param model model with user's actions to append.
 */
- (void)appendListWithModel:(nullable ActionsListModel *)model;

/**
 * A delegate that is responsible for loading actions list.
 */
@property(nonatomic, weak) id<ActionsListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
