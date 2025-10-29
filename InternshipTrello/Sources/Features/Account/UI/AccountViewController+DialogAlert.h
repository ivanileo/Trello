//
//  AuthorizationPageViewController+DialogAlert.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.10.2021.
//

#import <Foundation/Foundation.h>
#import "AccountViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountViewController (DialogAlert)

- (void)showAlertDialogWithHandler:(void (^)(UIAlertAction *))handler;

@end

NS_ASSUME_NONNULL_END
