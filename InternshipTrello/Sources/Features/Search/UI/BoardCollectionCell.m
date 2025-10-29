//
//  BoardCollectionCell.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 15.12.2021.
//

#import "BoardCell.h"
#import "BoardCollectionCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BoardCollectionCell {
    BoardCell *_boardCellView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _boardCellView = [[BoardCell alloc] initWithFrame:CGRectZero];
        _boardCellView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_boardCellView];
        [self buildLayout];
    }
    return self;
}

- (void)updateWithItemModel:(BoardsListItemModel *)model {
    [_boardCellView updateWithItemModel:model];
}

- (void)buildLayout {
    [_boardCellView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [_boardCellView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [_boardCellView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [_boardCellView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    
    [self.contentView.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width].active = YES;
}

@end

NS_ASSUME_NONNULL_END
