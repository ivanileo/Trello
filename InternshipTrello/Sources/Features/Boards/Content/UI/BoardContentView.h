//
//  BoardContentView.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 23.11.2021.
//

#import <UIKit/UIKit.h>

#import "BoardDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A delegate for BoardContentView to handle refreshing data.
 */
@protocol BoardContentViewDelegate <NSObject>

/**
 * Reloads board content view.
 */
- (void)boardsContentViewShouldRefreshData;

@end

/**
 * A view that represents content of board with details and cards.
 */
@interface BoardContentView : UIView

/**
 * Reloads board's content with specific BoardDetailsModel model.
 *
 * @param model model with data.
 */
- (void)reloadWithModel:(nullable BoardDetailsModel *)model;

/**
 * A delegate that is responsible for refreshing cards.
 */
@property(nonatomic, weak) id<BoardContentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
