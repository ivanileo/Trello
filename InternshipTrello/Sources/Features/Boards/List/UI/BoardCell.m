//
//  BoardCell.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 09.11.2021.
//

#import "BoardCell.h"
#import "UIImageView+ImageLoader.h"

NS_ASSUME_NONNULL_BEGIN

/** Name label consts. */
static NSString *const kBoardNameFontName = @"Helvetica";
static const CGFloat kBoardNameFontSize = 20;

/** Layout consts. */
static const CGFloat kImageHeight = 42;
static const CGFloat kRatioImageHeightToCellHeight = 0.6;
static const CGFloat kMarginBetweenEdges = kImageHeight * (1 / kRatioImageHeightToCellHeight - 1) / 2;

/** Board image view consts. */
static const CGFloat kBoardPlaceholderImageViewCornerRadius = 6;
static NSString *const kBoardPlaceholderImageName = @"note";

@implementation BoardCell {
    BoardsListItemModel *_model;
    UIImageView *_boardImageView;
    UILabel *_boardNameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createImageView];
        [self createNameLabel];
        [self buildLayout];
    }
    return self;
}

- (void)updateWithItemModel:(BoardsListItemModel *)model {
    _model = model;
    _boardNameLabel.text = _model.name;
    UIImage *icon = [UIImage systemImageNamed:kBoardPlaceholderImageName];
    UIImage *placeholder = [icon imageWithTintColor:UIColor.systemGrayColor
                                       renderingMode:UIImageRenderingModeAlwaysOriginal];
    if (_model.imageUrl) {
        [_boardImageView setImageWithUrl:[NSURL URLWithString:_model.imageUrl] andPlaceholder:placeholder];
    } else {
        _boardImageView.image = placeholder;
    }
}

- (void)createImageView {
    _boardImageView = [[UIImageView alloc] init];
    _boardImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _boardImageView.contentMode = UIViewContentModeScaleAspectFill;
    _boardImageView.clipsToBounds = YES;
    _boardImageView.layer.cornerRadius = kBoardPlaceholderImageViewCornerRadius;
    [self addSubview:_boardImageView];
}

- (void)createNameLabel {
    _boardNameLabel = [[UILabel alloc] init];
    _boardNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _boardNameLabel.font = [UIFont fontWithName:kBoardNameFontName size:kBoardNameFontSize];
    [self addSubview:_boardNameLabel];
}

- (void)buildLayout {
    [_boardImageView.heightAnchor constraintEqualToAnchor:self.heightAnchor
                                               multiplier:kRatioImageHeightToCellHeight].active = YES;
    [_boardImageView.widthAnchor constraintEqualToAnchor:_boardImageView.heightAnchor].active = YES;
    [_boardImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [_boardImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                  constant:kMarginBetweenEdges].active = YES;
    
    NSLayoutConstraint *heightConstraint = [_boardImageView.heightAnchor constraintEqualToConstant:kImageHeight];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    heightConstraint.active = YES;
    
    [_boardNameLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [_boardNameLabel.leadingAnchor constraintEqualToAnchor:_boardImageView.trailingAnchor
                                                  constant:kMarginBetweenEdges].active = YES;
    [_boardNameLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                   constant:-kMarginBetweenEdges].active = YES;
}

@end

NS_ASSUME_NONNULL_END
