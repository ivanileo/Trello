//
//  UIViewController+ErrorAlert.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A category that extends UIViewController for showing error alerts.
 */
@interface UIViewController (ErrorAlert)

/**
 * Shows alert with specific error message.
 *
 * @param message message about occured error.
 */
- (void)showErrorAlertWithMessage:(NSString *)message;

/**
 * Shows alert with specific error message.
 *
 * @param error occured error, localized description of which will be displayed.
 */
- (void)showAlertWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
