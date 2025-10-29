//
//  ActionsListItemCell.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 07.12.2021.
//

#import <UIKit/UIKit.h>

#import "ActionsListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A cell that represents action in ActionsListView's table.
 */
@interface ActionsListItemCell : UITableViewCell

/**
 * Updates cell with information from ActionsListItemModel model.
 *
 * @param model model with information about action to show in actions list.
 */
- (void)updateWithItemModel:(ActionsListItemModel *)model;

@end

NS_ASSUME_NONNULL_END
