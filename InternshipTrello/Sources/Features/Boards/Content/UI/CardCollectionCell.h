//
//  CardCollectionCell.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 24.11.2021.
//

#import <UIKit/UIKit.h>

#import "BoardDetailsModel.h"
#import "CardsListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * An item view for card in collection view with cards.
 */
@interface CardCollectionCell : UICollectionViewCell

/**
 * Reloads board's card with specific CardsListItemModel model.
 *
 * @param model model with data.
 */
- (void)reloadWithItemModel:(CardsListItemModel *)model;

@end

NS_ASSUME_NONNULL_END
