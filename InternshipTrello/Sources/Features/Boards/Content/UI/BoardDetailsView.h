//
//  BoardDetailsView.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 26.11.2021.
//

#import <UIKit/UIKit.h>

#import "BoardDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A view that represents board's details.
 */
@interface BoardDetailsView : UIView

/**
 * Reloads board's information with specific BoardDetailsModel model.
 *
 * @param model model with data.
 */
- (void)reloadWithModel:(nullable BoardDetailsModel *)model;

@end

NS_ASSUME_NONNULL_END
