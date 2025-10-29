//
//  BoardsListView.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 08.11.2021.
//

#import "BoardTableCell.h"
#import "BoardsListView.h"
#import "NSObject+Identifier.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoardsListView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BoardsListView {
    BoardsListModel *_listModel;
    UITableView *_boardsTableView;
    BoardContentRouter *_router;
}

- (instancetype)initWithRouter:(BoardContentRouter *)router {
    self = [super init];
    if (self) {
        _router = router;
        self.backgroundColor = UIColor.systemBackgroundColor;
        [self createTable];
        [self createRefreshControl];
        [self buildLayout];
    }
    return self;
}

- (void)reloadWithModel:(nullable BoardsListModel *)model {
    _listModel = model;
    [_boardsTableView reloadData];
    [_boardsTableView.refreshControl endRefreshing];
}

- (void)createTable {
    _boardsTableView = [[UITableView alloc] init];
    _boardsTableView.dataSource = self;
    _boardsTableView.delegate = self;
    _boardsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [_boardsTableView registerClass:BoardTableCell.class forCellReuseIdentifier:[BoardTableCell identifier]];
    [self addSubview:_boardsTableView];
}

- (void)createRefreshControl {
    _boardsTableView.refreshControl = [[UIRefreshControl alloc] init];
    [_boardsTableView.refreshControl addTarget:self.delegate
                                        action:@selector(boardsListViewShouldRefreshData)
                              forControlEvents:UIControlEventValueChanged];
}

- (void)buildLayout {
    [_boardsTableView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_boardsTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_boardsTableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_boardsTableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BoardTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[BoardTableCell identifier]
                                                           forIndexPath:indexPath];
    [cell updateWithItemModel: _listModel.items[indexPath.item]];
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_router showBoardContentWithBoardId:_listModel.items[indexPath.row].boardId];
}

@end

NS_ASSUME_NONNULL_END
