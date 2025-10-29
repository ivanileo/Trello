//
//  ActionsListItemCell.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 07.12.2021.
//

#import "ActionsListItemCell.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Constants

/** Primary text consts. */
static NSString *const kPrimaryTextFontName = @"Helvetica";
static const CGFloat kPrimaryTextFontSize = 15;

/** Secondary text consts. */
static NSString *const kSecondaryTextFontName = @"Helvetica";
static const CGFloat kSecondaryTextFontSize = 11;

/** Tertiary text consts. */
static NSString *const kTertiaryTextFontName = @"Helvetica";
static const CGFloat kTertiaryTextFontSize = 9;

/** Background view consts. */
static const CGFloat kBackgroundCornerRadius = 8;

/** Layout consts. */
static const CGFloat kBackgroundInset = 8;
static const CGFloat kBackgroundHeight = 60;
static const CGFloat kContentLeadingTrailingInset = 40;
static const CGFloat kContentInset = 8;

@implementation ActionsListItemCell {
    ActionsListItemModel *_model;
    UILabel *_actionTypeLabel;
    UILabel *_usernameLabel;
    UILabel *_dateLabel;
    UILabel *_actionIdLabel;
    UIView *_backgroundView;
    NSDateFormatter *_dateFormatterFromISO;
    NSDateFormatter *_dateFormatterToDisplay;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createDateFormatters];
        [self createBackground];
        [self createActionTypeLabel];
        [self createUsernameLabel];
        [self createDateLabel];
        [self createActionIdLabel];
        [self buildLayout];
    }
    return self;
}

#pragma mark - Public methods

- (void)updateWithItemModel:(ActionsListItemModel *)model {
    _model = model;
    _actionTypeLabel.text = model.type;
    _actionIdLabel.text = model.actionId;
    _usernameLabel.text = model.username;
    NSDate *date = [_dateFormatterFromISO dateFromString:model.date];
    _dateLabel.text =  [_dateFormatterToDisplay stringFromDate:date];
}

#pragma mark - Private methods

- (void)createDateFormatters {
    _dateFormatterFromISO = [[NSDateFormatter alloc] init];
    _dateFormatterFromISO.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    _dateFormatterFromISO.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    _dateFormatterToDisplay = [[NSDateFormatter alloc] init];
    _dateFormatterToDisplay.dateFormat = NSLocalizedStringFromTable(@"displayed_date_format", @"Actions", @"");
}

- (void)createActionTypeLabel {
    _actionTypeLabel = [[UILabel alloc] init];
    _actionTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _actionTypeLabel.font = [UIFont fontWithName:kPrimaryTextFontName size:kPrimaryTextFontSize];
    [self.contentView addSubview:_actionTypeLabel];
}

- (void)createUsernameLabel {
    _usernameLabel = [[UILabel alloc] init];
    _usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _usernameLabel.font = [UIFont fontWithName:kPrimaryTextFontName size:kPrimaryTextFontSize];
    [self.contentView addSubview:_usernameLabel];
}

- (void)createDateLabel {
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _dateLabel.font = [UIFont fontWithName:kSecondaryTextFontName size:kSecondaryTextFontSize];
    _dateLabel.textColor = UIColor.secondaryLabelColor;
    [self.contentView addSubview:_dateLabel];
}

- (void)createActionIdLabel {
    _actionIdLabel = [[UILabel alloc] init];
    _actionIdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _actionIdLabel.font = [UIFont fontWithName:kTertiaryTextFontName size:kTertiaryTextFontSize];
    _actionIdLabel.textColor = UIColor.tertiaryLabelColor;
    [self.contentView addSubview:_actionIdLabel];
}

- (void)createBackground {
    _backgroundView = [[UIView alloc] init];
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    _backgroundView.backgroundColor = UIColor.systemGray5Color;
    _backgroundView.layer.cornerRadius = kBackgroundCornerRadius;
    [self.contentView addSubview:_backgroundView];
}

- (void)buildLayout {
    [_backgroundView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor
                                              constant:kBackgroundInset].active = YES;
    [_backgroundView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor
                                                 constant:-kBackgroundInset].active = YES;
    [_backgroundView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor
                                                  constant:kBackgroundInset].active = YES;
    [_backgroundView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor
                                                   constant:-kBackgroundInset].active = YES;
    [_backgroundView.heightAnchor constraintEqualToConstant:kBackgroundHeight].active = YES;
    
    [_actionTypeLabel.topAnchor constraintEqualToAnchor:_backgroundView.topAnchor
                                               constant:kContentInset].active = YES;
    [_actionTypeLabel.leadingAnchor constraintEqualToAnchor:_backgroundView.leadingAnchor
                                                   constant:kContentLeadingTrailingInset].active = YES;
    
    [_usernameLabel.topAnchor constraintEqualToAnchor:_actionTypeLabel.topAnchor].active = YES;
    [_usernameLabel.trailingAnchor constraintEqualToAnchor:_backgroundView.trailingAnchor
                                                  constant:-kContentLeadingTrailingInset].active = YES;
    [_usernameLabel.leadingAnchor constraintGreaterThanOrEqualToAnchor:_actionTypeLabel.trailingAnchor].active = YES;
    
    [_dateLabel.bottomAnchor constraintEqualToAnchor:_backgroundView.bottomAnchor
                                            constant:-kContentInset].active = YES;
    [_dateLabel.leadingAnchor constraintEqualToAnchor:_actionTypeLabel.leadingAnchor].active = YES;
    [_dateLabel.topAnchor constraintGreaterThanOrEqualToAnchor:_actionTypeLabel.bottomAnchor].active = YES;
    
    [_actionIdLabel.bottomAnchor constraintEqualToAnchor:_dateLabel.bottomAnchor].active = YES;
    [_actionIdLabel.trailingAnchor constraintEqualToAnchor:_usernameLabel.trailingAnchor].active = YES;
    [_actionIdLabel.leadingAnchor constraintGreaterThanOrEqualToAnchor:_dateLabel.trailingAnchor].active = YES;
    [_actionIdLabel.topAnchor constraintGreaterThanOrEqualToAnchor:_actionTypeLabel.bottomAnchor].active = YES;
}

@end

NS_ASSUME_NONNULL_END
