//
//  AuthorizationPageView.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 12.10.2021.
//

#import "Account.h"
#import "AuthorizationPageView.h"
#import "AccountViewController.h"
#import "AuthorizeButton.h"
#import "PlistManager.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Constants

/** Activity indicator consts. */
static const CGFloat kActivityIndicatorViewWidth = 50;
static const CGFloat kActivityIndicatorViewHeight = 50;
static const UIActivityIndicatorViewStyle kIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;

/** Authorization button consts. */
static NSString *const kAuthButtonFontName = @"Helvetica";
static const CGFloat kAuthButtonFontSize = 24;

/** Title label consts. */
static NSString *const kTitleLabelFontName = @"Helvetica";
static const CGFloat kTitleLabelFontSize = 50;

/** Autolayout consts. */
static const CGFloat kHeightBetweenAuthButtonAndTitleLabel = 40;
static const CGFloat kHeightBetweenAuthButtonAndActivityIndicator = 40;

/** Constants for reading plist with titles. */
static NSString *const kTitleLabelTextKey = @"TitleLabelText";
static NSString *const kAuthButtonTextKey = @"AuthorizationButtonText";

@implementation AuthorizationPageView {
    UIButton *_authButton;
    UILabel *_titleLabel;
    UIActivityIndicatorView *_activityView;
}

/** Notifications consts. */
NSString *const kRequestAuthorizationNotification = @"RequestAuthorizationNotification";

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.systemBackgroundColor;
        [self createSubviews];
        [self buildLayout];
        [self setTitles];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _authButton.layer.cornerRadius = _authButton.bounds.size.height / 2;
}

#pragma mark - Actions

- (void)authButtonDidTap {
    [_activityView startAnimating];
    [NSNotificationCenter.defaultCenter postNotificationName:kRequestAuthorizationNotification
                                                      object:self];
}

#pragma mark - Public methods

- (void)finishAuthorization {
    [_activityView stopAnimating];
}

#pragma mark - Private methods

- (void)createSubviews {
    [self createAuthorizeButton];
    [self createTitleLabel];
    [self createActivityIndicatorView];
}

- (void)setTitles {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    _titleLabel.text = NSLocalizedStringFromTableInBundle(@"trello_title", kAccountTableName, bundle, @"");
    NSString *authButtonTitle = NSLocalizedStringFromTableInBundle(@"auth_button", kAccountTableName, bundle, @"");
    [_authButton setTitle:authButtonTitle forState:UIControlStateNormal];
}

- (void)buildLayout {
    [_authButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [_authButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    [_titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_titleLabel.bottomAnchor constraintEqualToAnchor:_authButton.topAnchor
                                             constant:-kHeightBetweenAuthButtonAndTitleLabel].active = YES;
    
    [_activityView.widthAnchor constraintEqualToConstant:kActivityIndicatorViewWidth].active = YES;
    [_activityView.heightAnchor constraintEqualToConstant:kActivityIndicatorViewHeight].active = YES;
    [_activityView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_activityView.topAnchor constraintEqualToAnchor:_authButton.bottomAnchor
                                            constant:kHeightBetweenAuthButtonAndActivityIndicator].active = YES;
}

- (void)createAuthorizeButton {
    _authButton = [[AuthorizeButton alloc] init];
    _authButton.titleLabel.font = [UIFont fontWithName:kAuthButtonFontName size:kAuthButtonFontSize];
    _authButton.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
    [_authButton setTitleColor:UIColor.labelColor forState:UIControlStateNormal];
    _authButton.backgroundColor = UIColor.grayColor;
    _authButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_authButton addTarget:self action:@selector(authButtonDidTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_authButton];
}

- (void)createTitleLabel {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.textColor = UIColor.labelColor;
    _titleLabel.font = [UIFont fontWithName:kTitleLabelFontName size:kTitleLabelFontSize];
    [self addSubview:_titleLabel];
}

- (void)createActivityIndicatorView {
    _activityView = [[UIActivityIndicatorView alloc] init];
    _activityView.translatesAutoresizingMaskIntoConstraints = NO;
    [_activityView stopAnimating];
    _activityView.hidesWhenStopped = YES;
    [_activityView setColor:UIColor.labelColor];
    _activityView.activityIndicatorViewStyle = kIndicatorViewStyle;
    [self addSubview:_activityView];
}

@end

NS_ASSUME_NONNULL_END
