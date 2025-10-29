//
//  AccountInfoPageView.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 28.10.2021.
//

#import <UIKit/UIKit.h>

#import "AccountInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A view that represents account model with information.
 */
@interface AccountInfoPageView : UIView

extern NSString *const kRequestLogoutNotification;

/**
 * Updates page with values from AccountInfoModel model.
 *
 * @param model model with information about account.
 */
- (void)updateWithModel:(AccountInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
