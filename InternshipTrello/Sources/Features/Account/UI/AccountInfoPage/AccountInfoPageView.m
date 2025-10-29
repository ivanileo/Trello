//
//  AccountInfoPageView.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 28.10.2021.
//

#import "Account.h"
#import "AccountInfoModel.h"
#import "AccountInfoPageView.h"
#import "PlistManager.h"
#import "UIImageView+ImageLoader.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Constants

/** Account title consts. */
static NSString *const kAccountTitleFontName = @"Helvetica";
static const CGFloat kAccountTitleFontSize = 30;

/** Full name consts. */
static NSString *const kFullNameFontName = @"Helvetica";
static const CGFloat kFullNameFontSize = 50;

/** Avatar consts. */
static const CGFloat kAvatarWidth = 150;
static const CGFloat kAvatarHeight = 150;

/** Info table consts. */
static NSString *const kInfoTableTitlesFontName = @"Helvetica";
static const CGFloat kInfoTableTitlesFontSize = 20;
static NSString *const kInfoTableValuesFontName = @"Helvetica";
static const CGFloat kInfoTableValuesFontSize = 20;
static const CGFloat kInfoTableSpacing = 5;

/** Logout button consts. */
static NSString *const kLogoutButtonFontName = @"Helvetica";
static const CGFloat kLogoutButtonFontSize = 30;

/** Layout consts. */
static const CGFloat kHeightBetweenTopAndAccountTitle = 40;
static const CGFloat kHeightBetweenAccountTitleAndFullName = 20;
static const CGFloat kHeightBetweenFullNameAndAvatar = 20;
static const CGFloat kHeightBetweenAvatarAndInfoTable = 20;
static const CGFloat kInfoTableLeadingMargin = 30;
static const CGFloat kInfoTableTrailingMargin = 30;
static const CGFloat kHeightBetweenLogoutAndBottom = 30;

@implementation AccountInfoPageView {
    AccountInfoModel *_model;
    UILabel *_accountTitleLabel;
    UIImageView *_avatarView;
    UILabel *_fullNameLabel;
    UIStackView *_infoStackView;
    UILabel *_usernameTitleLabel;
    UILabel *_usernameLabel;
    UILabel *_initialsTitleLabel;
    UILabel *_initialsLabel;
    UILabel *_urlTitleLabel;
    UILabel *_urlLabel;
    UIButton *_logoutButton;
}

/** Notifications consts. */
NSString *const kRequestLogoutNotification = @"RequestLogoutNotification";

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

#pragma mark - Actions

- (void)logoutButtonDidTap {
    [NSNotificationCenter.defaultCenter postNotificationName:kRequestLogoutNotification
                                                      object:self];
}

#pragma mark - Public methods

- (void)updateWithModel:(AccountInfoModel *)model {
    _model = model;
    [self setValuesFromModel];
}

#pragma mark - Private methods

- (void)createSubviews {
    [self createAccountTitle];
    [self createAvatar];
    [self createFullNameTitle];
    [self createUserNameTitles];
    [self createInitialsTitles];
    [self createUrlTitles];
    [self createInfoView];
    [self createLogoutButton];
}

- (void)createAccountTitle {
    _accountTitleLabel = [[UILabel alloc] init];
    _accountTitleLabel.textAlignment = NSTextAlignmentCenter;
    _accountTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _accountTitleLabel.textColor = UIColor.labelColor;
    _accountTitleLabel.font = [UIFont fontWithName:kAccountTitleFontName size:kAccountTitleFontSize];
    [self addSubview:_accountTitleLabel];
}

- (void)createFullNameTitle {
    _fullNameLabel = [[UILabel alloc] init];
    _fullNameLabel.textAlignment = NSTextAlignmentCenter;
    _fullNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _fullNameLabel.textColor = UIColor.labelColor;
    _fullNameLabel.font = [UIFont fontWithName:kFullNameFontName size:kFullNameFontSize];
    [self addSubview:_fullNameLabel];
}

- (void)createAvatar {
    _avatarView = [[UIImageView alloc] init];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_avatarView];
}

- (void)createUserNameTitles {
    _usernameTitleLabel = [[UILabel alloc] init];
    _usernameTitleLabel.textColor = UIColor.labelColor;
    _usernameTitleLabel.font = [UIFont fontWithName:kInfoTableTitlesFontName size:kInfoTableTitlesFontSize];
    _usernameTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    _usernameLabel = [[UILabel alloc] init];
    _usernameLabel.textColor = UIColor.labelColor;
    _usernameLabel.font = [UIFont fontWithName:kInfoTableValuesFontName size:kInfoTableValuesFontSize];
    _usernameLabel.textAlignment = NSTextAlignmentRight;
}

- (void)createInitialsTitles {
    _initialsTitleLabel = [[UILabel alloc] init];
    _initialsTitleLabel.textColor = UIColor.labelColor;
    _initialsTitleLabel.font = [UIFont fontWithName:kInfoTableTitlesFontName size:kInfoTableTitlesFontSize];
    _initialsTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    _initialsLabel = [[UILabel alloc] init];
    _initialsLabel.textColor = UIColor.labelColor;
    _initialsLabel.font = [UIFont fontWithName:kInfoTableValuesFontName size:kInfoTableValuesFontSize];
    _initialsLabel.textAlignment = NSTextAlignmentRight;
}

- (void)createUrlTitles {
    _urlTitleLabel = [[UILabel alloc] init];
    _urlTitleLabel.textColor = UIColor.labelColor;
    _urlTitleLabel.font = [UIFont fontWithName:kInfoTableTitlesFontName size:kInfoTableTitlesFontSize];
    _urlTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    _urlLabel = [[UILabel alloc] init];
    _urlLabel.textColor = UIColor.labelColor;
    _urlLabel.font = [UIFont fontWithName:kInfoTableValuesFontName size:kInfoTableValuesFontSize];
    _urlLabel.textAlignment = NSTextAlignmentRight;
}

- (void)createInfoView {
    _infoStackView = [[UIStackView alloc] init];
    _infoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    _infoStackView.axis = UILayoutConstraintAxisVertical;
    _infoStackView.distribution = UIStackViewDistributionFillEqually;
    _infoStackView.spacing = kInfoTableSpacing;
    
    UIStackView *initialsRaw = [[UIStackView alloc] init];
    initialsRaw.axis = UILayoutConstraintAxisHorizontal;
    initialsRaw.distribution = UIStackViewDistributionFillProportionally;
    [initialsRaw addArrangedSubview:_initialsTitleLabel];
    [initialsRaw addArrangedSubview:_initialsLabel];
    [_infoStackView addArrangedSubview:initialsRaw];
    
    UIStackView *usernameRaw = [[UIStackView alloc] init];
    usernameRaw.axis = UILayoutConstraintAxisHorizontal;
    usernameRaw.distribution = UIStackViewDistributionFillProportionally;
    [usernameRaw addArrangedSubview:_usernameTitleLabel];
    [usernameRaw addArrangedSubview:_usernameLabel];
    [_infoStackView addArrangedSubview:usernameRaw];
    
    UIStackView *urlRaw = [[UIStackView alloc] init];
    urlRaw.axis = UILayoutConstraintAxisHorizontal;
    urlRaw.distribution = UIStackViewDistributionFillProportionally;
    [urlRaw addArrangedSubview:_urlTitleLabel];
    [urlRaw addArrangedSubview:_urlLabel];
    [_infoStackView addArrangedSubview:urlRaw];
    
    [self addSubview:_infoStackView];
}

- (void)createLogoutButton {
    _logoutButton = [[UIButton alloc] init];
    _logoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_logoutButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [_logoutButton setTitleColor:UIColor.grayColor forState:UIControlStateHighlighted];
    _logoutButton.titleLabel.font = [UIFont fontWithName:kLogoutButtonFontName size:kLogoutButtonFontSize];
    [_logoutButton addTarget:self action:@selector(logoutButtonDidTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_logoutButton];
}

- (void)buildLayout {
    [_accountTitleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_accountTitleLabel.topAnchor constraintEqualToAnchor:self.topAnchor
                                                 constant:kHeightBetweenTopAndAccountTitle].active = YES;
    
    [_fullNameLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_fullNameLabel.topAnchor constraintEqualToAnchor:_accountTitleLabel.bottomAnchor
                                             constant:kHeightBetweenAccountTitleAndFullName].active = YES;
    
    [_avatarView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_avatarView.topAnchor constraintEqualToAnchor:_fullNameLabel.bottomAnchor
                                          constant:kHeightBetweenFullNameAndAvatar].active = YES;
    [_avatarView.widthAnchor constraintEqualToConstant:kAvatarWidth].active = YES;
    [_avatarView.heightAnchor constraintEqualToConstant:kAvatarHeight].active = YES;
    
    [_infoStackView.topAnchor constraintEqualToAnchor:_avatarView.bottomAnchor
                                             constant:kHeightBetweenAvatarAndInfoTable].active = YES;
    [_infoStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                  constant:-kInfoTableTrailingMargin].active = YES;
    [_infoStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                 constant:kInfoTableLeadingMargin].active = YES;
    
    [_logoutButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_logoutButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor
                                               constant:-kHeightBetweenLogoutAndBottom].active = YES;
}

- (void)setTitles {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    _accountTitleLabel.text = NSLocalizedStringFromTableInBundle(@"account_title", kAccountTableName, bundle, @"");
    _usernameTitleLabel.text = NSLocalizedStringFromTableInBundle(@"username_title", kAccountTableName, bundle, @"");
    _initialsTitleLabel.text = NSLocalizedStringFromTableInBundle(@"initials_title", kAccountTableName, bundle, @"");
    _urlTitleLabel.text = NSLocalizedStringFromTableInBundle(@"url_title", kAccountTableName, bundle, @"");
    NSString *logoutButtonLabel = NSLocalizedStringFromTableInBundle(@"logout_button", kAccountTableName, bundle, @"");
    [_logoutButton setTitle:logoutButtonLabel forState:UIControlStateNormal];
}

- (void)setValuesFromModel {
    _usernameLabel.text = _model.username;
    _urlLabel.text = _model.url;
    _initialsLabel.text = _model.initials;
    _fullNameLabel.text = _model.fullName;
    [_avatarView setImageWithUrl:[NSURL URLWithString:_model.avatarUrl] andPlaceholder:nil];
}

@end

NS_ASSUME_NONNULL_END
