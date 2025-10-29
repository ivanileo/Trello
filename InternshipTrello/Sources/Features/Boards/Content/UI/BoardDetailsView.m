//
//  BoardDetailsView.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 26.11.2021.
//

#import "BoardDetailsView.h"

NS_ASSUME_NONNULL_BEGIN

/** Layout consts. */
static const CGFloat kBackgroundInset = 8;
static const CGFloat kContentInset = kBackgroundInset * 3;

/** Name label consts. */
static NSString *const kNameLabelFontName = @"Helvetica";
static const CGFloat kNameLabelFontSize = 20;

/** Desc label consts. */
static NSString *const kDescLabelFontName = @"Helvetica";
static const CGFloat kDescLabelFontSize = 15;

/** Background view consts. */
static const CGFloat kBackgroundViewCornerRadius = 8;

@implementation BoardDetailsView {
    BoardDetailsModel *_model;
    UILabel *_nameLabel;
    UILabel *_descLabel;
    UIView *_backgroundView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createBackground];
        [self createNameLabel];
        [self createDescLabel];
        [self buildLayout];
    }
    return self;
}

- (void)reloadWithModel:(nullable BoardDetailsModel *)model {
    _model = model;
    _nameLabel.text = model.name;
    if (model.desc.length == 0) {
        _descLabel.text = NSLocalizedStringFromTableInBundle(@"empty_board_desc", @"Boards",
                                                             [NSBundle bundleForClass:self.class], @"");
    } else {
        _descLabel.text = model.desc;
    }
}

#pragma mark - Private methods

- (void)createNameLabel {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.font = [UIFont fontWithName:kNameLabelFontName size:kNameLabelFontSize];
    [self addSubview:_nameLabel];
}

- (void)createDescLabel {
    _descLabel = [[UILabel alloc] init];
    _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descLabel.numberOfLines = 0;
    _descLabel.font = [UIFont fontWithName:kDescLabelFontName size:kDescLabelFontSize];
    [self addSubview:_descLabel];
}

- (void)createBackground {
    _backgroundView = [[UIView alloc] init];
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    _backgroundView.backgroundColor = UIColor.systemGray2Color;
    _backgroundView.layer.cornerRadius = kBackgroundViewCornerRadius;
    [self addSubview:_backgroundView];
}

- (void)buildLayout {
    [_backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kBackgroundInset].active = YES;
    [_backgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-kBackgroundInset].active = YES;
    [_backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kBackgroundInset].active = YES;
    [_backgroundView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kBackgroundInset].active = YES;
    
    [_nameLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:kContentInset].active = YES;
    [_nameLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kContentInset].active = YES;
    [_nameLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kContentInset].active = YES;
    
    [_descLabel.topAnchor constraintEqualToAnchor:_nameLabel.topAnchor constant:kContentInset].active = YES;
    [_descLabel.leadingAnchor constraintEqualToAnchor:_nameLabel.leadingAnchor].active = YES;
    [_descLabel.trailingAnchor constraintEqualToAnchor:_nameLabel.trailingAnchor].active = YES;
    [_descLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor constant:-kContentInset].active = YES;
}

@end

NS_ASSUME_NONNULL_END
