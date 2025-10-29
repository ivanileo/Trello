//
//  UIViewController+ErrorAlert.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.11.2021.
//

#import "UIViewController+ErrorAlert.h"

/** Error alert consts. */
static NSString *const kErrorAlertTitle = @"Error occured:";
static NSString *const kErrorButtonTitle = @"Dismiss";

@implementation UIViewController (ErrorAlert)

- (void)showErrorAlertWithMessage:(NSString *)message {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:kErrorAlertTitle
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    [errorAlert addAction:[UIAlertAction actionWithTitle:kErrorButtonTitle
                                                   style:UIAlertActionStyleDefault
                                                 handler:nil]];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)showAlertWithError:(NSError *)error {
    [self showErrorAlertWithMessage:error.localizedDescription];
}

@end
