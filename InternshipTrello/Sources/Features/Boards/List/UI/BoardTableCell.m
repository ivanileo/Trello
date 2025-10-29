//
//  BoardTableCell.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 15.12.2021.
//

#import "BoardCell.h"
#import "BoardTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BoardTableCell {
    BoardCell *_boardCellView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
}

@end

NS_ASSUME_NONNULL_END
