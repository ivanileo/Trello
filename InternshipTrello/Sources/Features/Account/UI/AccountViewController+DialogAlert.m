//
//  AuthorizationPageViewController+DialogAlert.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.10.2021.
//

#import "Account.h"
#import "AccountViewController+DialogAlert.h"
#import "AccountViewController.h"

NS_ASSUME_NONNULL_BEGIN

/** Confirmation dialog alert consts. */
static const UIAlertControllerStyle kConfirmationAlertStyle = UIAlertControllerStyleAlert;
static const UIAlertActionStyle kAlertActionConfirmStyle = UIAlertActionStyleDefault;
static const UIAlertActionStyle kAlertActionCancelStyle = UIAlertActionStyleCancel;

@implementation AccountViewController (DialogAlert)

- (void)showAlertDialogWithHandler:(void (^)(UIAlertAction *))handler {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *confirmationAlertTitle = NSLocalizedStringFromTableInBundle(@"authorized_alert_title",
                                                                          kAccountTableName,
                                                                          bundle,
                                                                          @"");
    NSString *confirmationAlertMessage = NSLocalizedStringFromTableInBundle(@"authorized_alert_message",
                                                                            kAccountTableName,
                                                                            bundle,
                                                                            @"");
    NSString *confirmationAlertContinueTitle = NSLocalizedStringFromTableInBundle(@"authorized_alert_continue",
                                                                                  kAccountTableName,
                                                                                  bundle,
                                                                                  @"");
    NSString *confirmationAlertCancelTitle = NSLocalizedStringFromTableInBundle(@"authorized_alert_cancel",
                                                                                kAccountTableName,
                                                                                bundle,
                                                                                @"");
    UIAlertController *confirmationAlert = [UIAlertController alertControllerWithTitle:confirmationAlertTitle
                                                                               message:confirmationAlertMessage
                                                                        preferredStyle:kConfirmationAlertStyle];
    [confirmationAlert addAction:[UIAlertAction actionWithTitle:confirmationAlertCancelTitle
                                                          style:kAlertActionCancelStyle
                                                        handler:handler]];
    [confirmationAlert addAction:[UIAlertAction actionWithTitle:confirmationAlertContinueTitle
                                                          style:kAlertActionConfirmStyle
                                                        handler:handler]];
    [self presentViewController:confirmationAlert animated:YES completion:nil];
}

@end

NS_ASSUME_NONNULL_END
