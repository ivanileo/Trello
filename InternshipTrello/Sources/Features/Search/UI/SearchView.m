//
//  SearchView.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 13.12.2021.
//

#import "BaseSectionHeaderView.h"
#import "BoardCollectionCell.h"
#import "CardCollectionCell.h"
#import "NSObject+Identifier.h"
#import "SearchView.h"

NS_ASSUME_NONNULL_BEGIN

/** Strings table for localized strings. */
static NSString *const kStringsTable = @"Search";

/** Search bar consts. */
static NSString *const kSearchBarFontName = @"Helvetica";
static const CGFloat kSearchBarFontSize = 15;

/** Note label consts. */
static NSString *const kNoteLabelFontName = @"Helvetica";
static const CGFloat kNoteLabelFontSize = 12;

/** Layout consts. */
static const CGFloat kHeightBetweenNoteAndMessageLabels = 30;

/** Search delay. */
static const float kSearchDelaySeconds = 0.5;

/** Count of sections. */
static NSUInteger kSectionsCount = 2;

/** Types for sections. */
typedef NS_ENUM (NSUInteger, SearchSection) {
    BoardsSection,
    CardsSection
};

SearchSection SectionFromInt(NSUInteger section) {
    switch (section) {
        case 0:
            return BoardsSection;
        case 1:
            return CardsSection;
    }
    return -1;
}

@interface SearchView () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation SearchView {
    UILabel *_noteLabel;
    UILabel *_messageLabel;
    UISearchBar *_searchBar;
    UIActivityIndicatorView *_searchIndicatorView;
    UICollectionView *_collectionView;
    SearchResultModel *_model;
    BoardContentRouter *_router;
}

- (instancetype)initWithRouter:(BoardContentRouter *)router {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _router = router;
        self.backgroundColor = UIColor.systemBackgroundColor;
        [self createNoteLabel];
        [self createSearchBar];
        [self createSearchIndicatorView];
        [self createCollectionView];
        [self createMessageLabel];
        [self buildLayout];
        [self showViewForSearchSuccessful:NO withMessage:nil];
        [self setupGestureRecognizers];
    }
    return self;
}

- (void)handleAppearing {
    [_searchBar becomeFirstResponder];
}

- (void)setupGestureRecognizers {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [_searchBar resignFirstResponder];
}

- (void)createNoteLabel {
    _noteLabel = [[UILabel alloc] init];
    _noteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _noteLabel.textColor = UIColor.systemGray3Color;
    _noteLabel.font = [UIFont fontWithName:kNoteLabelFontName size:kNoteLabelFontSize];
    _noteLabel.text = NSLocalizedStringFromTable(@"note", kStringsTable, @"");
    [self addSubview:_noteLabel];
}

- (void)createSearchBar {
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    _searchBar.placeholder = NSLocalizedStringFromTable(@"search_bar_placeholder", kStringsTable, @"");
    [self addSubview:_searchBar];
}

- (void)createSearchIndicatorView {
    _searchIndicatorView = [[UIActivityIndicatorView alloc]
                            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    _searchIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_searchIndicatorView];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:CardCollectionCell.class
        forCellWithReuseIdentifier:CardCollectionCell.identifier];
    [_collectionView registerClass:BoardCollectionCell.class
        forCellWithReuseIdentifier:BoardCollectionCell.identifier];
    [_collectionView registerClass:BaseSectionHeaderView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:BaseSectionHeaderView.identifier];
    
    [self addSubview:_collectionView];
}

- (void)createMessageLabel {
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _messageLabel.textColor = UIColor.systemGray3Color;
    _messageLabel.font = [UIFont fontWithName:kSearchBarFontName size:kSearchBarFontSize];
    [self addSubview:_messageLabel];
}

- (void)buildLayout {
    [_searchBar.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_searchBar.leadingAnchor constraintEqualToAnchor:_searchIndicatorView.trailingAnchor].active = YES;
    [_searchBar.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    [_searchIndicatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_searchIndicatorView.centerYAnchor constraintEqualToAnchor:_searchBar.centerYAnchor].active = YES;
    
    [_noteLabel.topAnchor constraintEqualToAnchor:_searchBar.bottomAnchor].active = YES;
    [_noteLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_noteLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    [_collectionView.topAnchor constraintEqualToAnchor:_noteLabel.bottomAnchor].active = YES;
    [_collectionView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_collectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [_collectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    [_messageLabel.topAnchor constraintEqualToAnchor:_noteLabel.bottomAnchor
                                            constant:kHeightBetweenNoteAndMessageLabels].active = YES;
    [_messageLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestSearch) object:nil];
    if ([searchText isEqualToString:@""]) {
        [self showViewForSearchSuccessful:NO withMessage:nil];
        [_searchIndicatorView stopAnimating];
    } else {
        [self performSelector:@selector(requestSearch) withObject:nil afterDelay:kSearchDelaySeconds];
        [_searchIndicatorView startAnimating];
    }
}

- (void)requestSearch {
    [self.delegate performSearchWithQuery:_searchBar.text];
}

- (void)showSearchResultWithModel:(SearchResultModel *)model andRequestedQuery:(NSString *)searchQuery {
    if (![searchQuery isEqualToString:_searchBar.text]) {
        return;
    }
    if (model) {
        if (model.boards.items.count > 0 || model.cards.items.count > 0) {
            _model = model;
            [_collectionView reloadData];
            [self showViewForSearchSuccessful:YES withMessage:nil];
        } else {
            NSString *message = NSLocalizedStringFromTable(@"no_results_message", kStringsTable, @"");
            [self showViewForSearchSuccessful:NO withMessage:message];
        }
    } else {
        NSString *message = NSLocalizedStringFromTable(@"error_message", kStringsTable, @"");
        [self showViewForSearchSuccessful:NO withMessage:message];
    }
    [_searchIndicatorView stopAnimating];
}

- (void)showViewForSearchSuccessful:(BOOL)isSuccessful withMessage:(nullable NSString *)message {
    _collectionView.hidden = !isSuccessful;
    _messageLabel.hidden = isSuccessful;
    _messageLabel.text = message;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (SectionFromInt(section)) {
        case BoardsSection:
            return _model.boards.items.count;
        case CardsSection:
            return _model.cards.items.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kSectionsCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (SectionFromInt(indexPath.section)) {
        case BoardsSection: {
            BoardCollectionCell *cell = [collectionView
                                         dequeueReusableCellWithReuseIdentifier:BoardCollectionCell.identifier
                                         forIndexPath:indexPath];
            [cell updateWithItemModel:_model.boards.items[indexPath.item]];
            return cell;
        }
        case CardsSection: {
            CardCollectionCell *cell = [collectionView
                                        dequeueReusableCellWithReuseIdentifier:CardCollectionCell.identifier
                                        forIndexPath:indexPath];
            [cell reloadWithItemModel:_model.cards.items[indexPath.item]];
            return cell;
        }
    }
    return [[UICollectionViewCell alloc] initWithFrame:CGRectZero];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BaseSectionHeaderView *section = [collectionView
                                          dequeueReusableSupplementaryViewOfKind:kind
                                          withReuseIdentifier:BaseSectionHeaderView.identifier
                                          forIndexPath:indexPath];
        switch (SectionFromInt(indexPath.section)) {
            case BoardsSection: {
                NSString *headerTitle = NSLocalizedStringFromTable(@"boards_section_header", kStringsTable, @"");
                [section updateWithTitle:headerTitle];
                break;
            }
            case CardsSection: {
                NSString *headerTitle = NSLocalizedStringFromTable(@"cards_section_header", kStringsTable, @"");
                [section updateWithTitle:headerTitle];
                break;
            }
        }
        return section;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    switch (SectionFromInt(section)) {
        case BoardsSection:
            return UIEdgeInsetsZero;
        case CardsSection: {
            if (_model.cards.items.count == 0) {
                return UIEdgeInsetsZero;
            }
            CGFloat edgeMargin = UIScreen.mainScreen.bounds.size.width * 0.05;
            return UIEdgeInsetsMake(edgeMargin, edgeMargin, edgeMargin, edgeMargin);
        }
    }
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat sectionHeaderHeight = UIScreen.mainScreen.bounds.size.height / 20;
    switch (SectionFromInt(section)) {
        case BoardsSection:
            return _model.boards.items.count == 0 ? CGSizeZero : CGSizeMake(0, sectionHeaderHeight);
        case CardsSection:
            return _model.cards.items.count == 0 ? CGSizeZero : CGSizeMake(0, sectionHeaderHeight);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (SectionFromInt(indexPath.section) == BoardsSection) {
        [_router showBoardContentWithBoardId:_model.boards.items[indexPath.item].boardId];
    }
}

@end

NS_ASSUME_NONNULL_END
