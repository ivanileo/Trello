//
//  BoardCell.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 09.11.2021.
//

#import <UIKit/UIKit.h>

#import "BoardsListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A cell that represents board.
 */
@interface BoardCell : UIView

/**
 * Updates cell with information from BoardsListItemModel model.
 *
 * @param model model with information about board to show in boards list.
 */
- (void)updateWithItemModel:(BoardsListItemModel *)model;

@end

NS_ASSUME_NONNULL_END
