//
//  BoardContentView.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 23.11.2021.
//

#import "CardCollectionCell.h"
#import "BoardContentView.h"
#import "BoardDetailsView.h"
#import "BaseSectionHeaderView.h"
#import "NSObject+Identifier.h"

NS_ASSUME_NONNULL_BEGIN

/** Layout consts. */
static const CGFloat kRatioDetailsViewHeightToScreenHeight = 0.15;

@interface BoardContentView () <UICollectionViewDataSource>

@end

@implementation BoardContentView {
    UICollectionView *_cardsCollectionView;
    BoardDetailsModel *_boardModel;
    BoardDetailsView *_detailsView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createDetailsView];
        [self createCollectionView];
        [self createRefreshControl];
        [self buildLayout];
    }
    return self;
}

- (void)createCollectionView {
    CGFloat edgeMargin = UIScreen.mainScreen.bounds.size.width * 0.05;
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    CGFloat sectionHeaderHeight = screenHeight / 20;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    layout.sectionInset = UIEdgeInsetsMake(edgeMargin, edgeMargin, edgeMargin, edgeMargin);
    layout.minimumLineSpacing = edgeMargin;
    layout.headerReferenceSize = CGSizeMake(0, sectionHeaderHeight);
    layout.sectionHeadersPinToVisibleBounds = YES;
    
    _cardsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _cardsCollectionView.dataSource = self;
    _cardsCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [_cardsCollectionView registerClass:CardCollectionCell.class
             forCellWithReuseIdentifier:CardCollectionCell.identifier];
    [_cardsCollectionView registerClass:BaseSectionHeaderView.class
             forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                    withReuseIdentifier:BaseSectionHeaderView.identifier];
    [self addSubview:_cardsCollectionView];
}

- (void)createDetailsView {
    _detailsView = [[BoardDetailsView alloc] init];
    _detailsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_detailsView];
}

- (void)createRefreshControl {
    _cardsCollectionView.refreshControl = [[UIRefreshControl alloc] init];
    [_cardsCollectionView.refreshControl addTarget:self.delegate
                                            action:@selector(boardsContentViewShouldRefreshData)
                                  forControlEvents:UIControlEventValueChanged];
}

- (void)buildLayout {
    [_detailsView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_detailsView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_detailsView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [_detailsView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:kRatioDetailsViewHeightToScreenHeight].active = YES;
    
    [_cardsCollectionView.topAnchor constraintEqualToAnchor:_detailsView.bottomAnchor].active = YES;
    [_cardsCollectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_cardsCollectionView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_cardsCollectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
}

- (void)reloadWithModel:(nullable BoardDetailsModel *)model {
    _boardModel = model;
    [_detailsView reloadWithModel:model];
    [_cardsCollectionView reloadData];
    [_cardsCollectionView.refreshControl endRefreshing];
}

#pragma mark - UICollectionViewDataSource methods

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BaseSectionHeaderView *section = [collectionView
                                          dequeueReusableSupplementaryViewOfKind:kind
                                          withReuseIdentifier:BaseSectionHeaderView.identifier
                                          forIndexPath:indexPath];
        [section updateWithTitle:_boardModel.categories.items[indexPath.section].name];
        return section;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _boardModel.categories.items[section].cards.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _boardModel.categories.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CardCollectionCell.identifier
                                                                         forIndexPath:indexPath];
    [cell reloadWithItemModel:_boardModel.categories.items[indexPath.section].cards[indexPath.item]];
    return cell;
}

@end

NS_ASSUME_NONNULL_END
