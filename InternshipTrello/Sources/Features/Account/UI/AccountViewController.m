//
//  AuthorizationPageViewController.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 12.10.2021.
//

#import "AccountInfoPageView.h"
#import "AccountService.h"
#import "AccountViewController.h"
#import "AccountViewController+DialogAlert.h"
#import "AuthorizationPageView.h"
#import "UIViewController+ErrorAlert.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AccountViewController {
    AccountInfoPageView *_accountInfoPageView;
    AuthorizationPageView *_authPageView;
    AccountService *_accountService;
}

/** Notifications consts. */
NSString *const kLoginNotification = @"LoginNotification";

#pragma mark - Lifecycle

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _accountService = [[AccountService alloc] init];
        _authPageView = [[AuthorizationPageView alloc] init];
        _accountInfoPageView = [[AccountInfoPageView alloc] init];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(receiveRequestLogoutNotification:)
                                                   name:kRequestLogoutNotification
                                                 object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(receiveRequestAuthorizationNotification:)
                                                   name:kRequestAuthorizationNotification
                                                 object:nil];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self addPageView:_authPageView];
    [self addPageView:_accountInfoPageView];
}

- (void)viewWillAppear:(BOOL)animated {
    BOOL isAuthorized = [_accountService isAuthorized];
    [self showViewForUserAuthorizedStatus:isAuthorized];
    if (isAuthorized) {
      [self fetchAccountInfo];
    }
}

#pragma mark - Private methods

- (void)showViewForUserAuthorizedStatus:(BOOL)isAuthorized {
  _authPageView.hidden = isAuthorized;
  _accountInfoPageView.hidden = !isAuthorized;
}

- (void)addPageView:(UIView *)pageView {
    [self.view addSubview:pageView];
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    [pageView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [pageView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [pageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [pageView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    pageView.hidden = YES;
}

- (void)beginAuthorization {
    __weak __typeof__(self) weakSelf = self;
    [_accountService authorizeWithCompletion:^(BOOL isSuccessful, NSError * _Nullable error) {
        __typeof__(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (error) {
            [strongSelf showErrorAlertWithMessage:error.localizedDescription];
        }
        [strongSelf finishAuthorizationWithSuccess:isSuccessful];
    }];
}

- (void)beginLogout {
    [self showViewForUserAuthorizedStatus:NO];
    [_accountService performLogout];
}

- (void)finishAuthorizationWithSuccess:(BOOL)isSuccessful {
    [_authPageView finishAuthorization];
    if (isSuccessful) {
        __weak __typeof__(self) weakSelf = self;
        [self showAlertDialogWithHandler:^(UIAlertAction * _Nonnull action) {
            __typeof__(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            switch (action.style) {
                case UIAlertActionStyleDefault:
                    [strongSelf fetchAccountInfo];
                    [NSNotificationCenter.defaultCenter postNotificationName:kLoginNotification
                                                                      object:self];
                    return;
                case UIAlertActionStyleCancel:
                    [strongSelf beginLogout];
                    return;
                default:
                    return;
            }
        }];
    }
}

- (void)fetchAccountInfo {
    __weak __typeof__(self) weakSelf = self;
    [_accountService getAccountInfoWithCompletion:^(AccountInfoModel * _Nullable model, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof__(self) strongSelf = weakSelf;
            if (!strongSelf) {
              return;
            }
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                [strongSelf showErrorAlertWithMessage:error.localizedDescription];
                return;
            }
            [strongSelf->_accountInfoPageView updateWithModel:model];
            [strongSelf showViewForUserAuthorizedStatus:YES];
        });
    }];
}

#pragma mark - Notifications handlers

- (void)receiveRequestAuthorizationNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:kRequestAuthorizationNotification]) {
        [self beginAuthorization];
    }
}

- (void)receiveRequestLogoutNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:kRequestLogoutNotification]) {
        [self beginLogout];
    }
}

@end

NS_ASSUME_NONNULL_END
