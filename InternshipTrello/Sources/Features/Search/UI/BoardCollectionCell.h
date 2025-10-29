//
//  BoardCollectionCell.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 15.12.2021.
//

#import <UIKit/UIKit.h>

#import "BoardsListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A cell that represents board in UICollectionView.
 */
@interface BoardCollectionCell : UICollectionViewCell

/**
 * Updates cell with information from BoardsListItemModel model.
 *
 * @param model model with information about board to show in boards list.
 */
- (void)updateWithItemModel:(BoardsListItemModel *)model;

@end

NS_ASSUME_NONNULL_END
