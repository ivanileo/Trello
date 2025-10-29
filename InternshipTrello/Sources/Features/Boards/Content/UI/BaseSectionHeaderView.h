//
//  BaseSectionHeaderView.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.11.2021.
//

#import <UIKit/UIKit.h>

#import "CategoriesListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A header view for section with title only.
 */
@interface BaseSectionHeaderView : UICollectionReusableView

/**
 * Reloads board's section header with specific title.
 *
 * @param title string with title.
 */
- (void)updateWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
