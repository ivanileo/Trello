//
//  CardCollectionCell.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 24.11.2021.
//

#import "CardCollectionCell.h"

NS_ASSUME_NONNULL_BEGIN

/** Name label consts. */
static NSString *const kNameLabelFontName = @"Helvetica";
static const CGFloat kNameLabelFontSize = 15;

/** Background view consts. */
static const CGFloat kCardCornerRadius = 8;

@implementation CardCollectionCell {
    CardsListItemModel *_model;
    UILabel *_nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = UIColor.systemGray2Color;
        self.contentView.layer.cornerRadius = kCardCornerRadius;
        [self createNameLabel];
        [self buildLayout];
    }
    return self;
}

- (void)createNameLabel {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.font = [UIFont fontWithName:kNameLabelFontName size:kNameLabelFontSize];
    _nameLabel.numberOfLines = 0;
    [self.contentView addSubview:_nameLabel];
}

- (void)buildLayout {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat cardWidth = (screenWidth / 2) - (screenWidth * 0.075);
    CGFloat cardHeight = cardWidth / 3;
    CGFloat nameLabelMargin = cardWidth * 0.05;
    [self.contentView.widthAnchor constraintEqualToConstant:cardWidth].active = YES;
    [self.contentView.heightAnchor constraintEqualToConstant:cardHeight].active = YES;
    
    [_nameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:nameLabelMargin].active = YES;
    [_nameLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:nameLabelMargin].active = YES;
    [_nameLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-nameLabelMargin].active = YES;
    [_nameLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor].active = YES;
}

- (void)reloadWithItemModel:(CardsListItemModel *)model {
    _model = model;
    _nameLabel.text = model.name;
}

@end

NS_ASSUME_NONNULL_END
