//
//  AuthorizationPageView.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 12.10.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthorizationPageView : UIView

extern NSString *const kRequestAuthorizationNotification;

/**
 * Handles finish authorization in ui view.
 */
- (void)finishAuthorization;

@end

NS_ASSUME_NONNULL_END
