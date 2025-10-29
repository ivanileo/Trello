//
//  BaseSectionHeaderView.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.11.2021.
//

#import "BaseSectionHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

/** Layout consts. */
static const CGFloat kBackgroundInset = 8;
static const CGFloat kContentInset = 18;

/** Name label consts. */
static NSString *const kNameLabelPostfix = @":";
static NSString *const kNameLabelFontName = @"Helvetica";
static const CGFloat kNameLabelFontSize = 20;

/** Background view consts. */
static const CGFloat kHeaderBackgroundCornerRadius = 8;

@implementation BaseSectionHeaderView {
    UILabel *_nameLabel;
    UIView *_headerBackground;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createHeaderBackground];
        [self createCategoryNameLabel];
        [self buildLayout];
    }
    return self;
}

- (void)buildLayout {
    [_headerBackground.topAnchor constraintEqualToAnchor:self.topAnchor constant:kBackgroundInset].active = YES;
    [_headerBackground.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-kBackgroundInset].active = YES;
    [_headerBackground.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kBackgroundInset].active = YES;
    [_headerBackground.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kBackgroundInset].active = YES;
    
    [_nameLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [_nameLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kContentInset].active = YES;
}

- (void)createCategoryNameLabel {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.font = [UIFont fontWithName:kNameLabelFontName size:kNameLabelFontSize];
    _nameLabel.numberOfLines = 0;
    [self addSubview:_nameLabel];
}

- (void)createHeaderBackground {
    _headerBackground = [[UIView alloc] init];
    _headerBackground.translatesAutoresizingMaskIntoConstraints = NO;
    _headerBackground.backgroundColor = UIColor.systemGray5Color;
    _headerBackground.layer.cornerRadius = kHeaderBackgroundCornerRadius;
    [self addSubview:_headerBackground];
}

- (void)updateWithTitle:(NSString *)title {
    _nameLabel.text = [title stringByAppendingString:kNameLabelPostfix];
}

@end

NS_ASSUME_NONNULL_END
