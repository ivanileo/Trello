//
//  ActionsListView.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 07.12.2021.
//

#import "ActionsListItemCell.h"
#import "ActionsListView.h"
#import "NSObject+Identifier.h"

NS_ASSUME_NONNULL_BEGIN

/** Append button consts. */
static NSString *const kAppendButtonFontName = @"Helvetica";
static const CGFloat kAppendButtonFontSize = 20;
static const CGFloat kAppendButtonCornerRadius = 8;

/** Layout consts. */
static const CGFloat kAppendButtonTopInset = 10;
static const CGFloat kActivityIndicatorTopInset = 15;
static const CGFloat kFooterHeight = 150;

@interface ActionsListView () <UITableViewDataSource>

@end

@implementation ActionsListView {
    ActionsListModel *_listModel;
    UITableView *_actionsTableView;
    UIButton *_appendButton;
    UIView *_tableFooterView;
    UIActivityIndicatorView *_activityIndicatorView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.systemBackgroundColor;
        [self createTable];
        [self createTableFooter];
        [self createAppendButton];
        [self createActivityIndicator];
        [self buildLayout];
    }
    return self;
}

#pragma mark - Public methods

- (void)reloadWithModel:(nullable ActionsListModel *)model {
    _listModel = model;
    [_actionsTableView reloadData];
}

- (void)appendListWithModel:(nullable ActionsListModel *)model {
    [_activityIndicatorView stopAnimating];
    NSUInteger previousCount = _listModel.items.count;
    [_listModel.items addObjectsFromArray:model.items];
    [self appendTableWithPreviousCount:previousCount];
}

#pragma mark - Private methods

- (void)appendTableWithPreviousCount:(NSUInteger)previousCount {
    NSMutableArray<NSIndexPath *> *paths = [[NSMutableArray alloc] init];
    for (NSUInteger index = previousCount; index < _listModel.items.count; index++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
        [paths addObject:path];
    }
    [_actionsTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationRight];
}

- (void)buildLayout {
    [_actionsTableView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_actionsTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_actionsTableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_actionsTableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    [_appendButton.topAnchor constraintEqualToAnchor:_tableFooterView.topAnchor
                                            constant:kAppendButtonTopInset].active = YES;
    [_appendButton.centerXAnchor constraintEqualToAnchor:_tableFooterView.centerXAnchor].active = YES;
    
    [_activityIndicatorView.topAnchor constraintEqualToAnchor:_appendButton.bottomAnchor
                                                     constant:kActivityIndicatorTopInset].active = YES;
    [_activityIndicatorView.centerXAnchor constraintEqualToAnchor:_tableFooterView.centerXAnchor].active = YES;
}

- (void)createTable {
    _actionsTableView = [[UITableView alloc] init];
    _actionsTableView.allowsSelection = NO;
    _actionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _actionsTableView.dataSource = self;
    _actionsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [_actionsTableView registerClass:ActionsListItemCell.class
              forCellReuseIdentifier:[ActionsListItemCell identifier]];
    [self addSubview:_actionsTableView];
}

- (void)createTableFooter {
    _tableFooterView = [[UIView alloc] init];
    _tableFooterView.frame = CGRectMake(0, 0, 0, kFooterHeight);
    _actionsTableView.tableFooterView = _tableFooterView;
}

- (void)createActivityIndicator {
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [_tableFooterView addSubview:_activityIndicatorView];
}

- (void)createAppendButton {
    _appendButton = [[UIButton alloc] init];
    NSString *title = NSLocalizedStringFromTable(@"append_button_title", @"Actions", @"");
    [_appendButton setTitle:title forState:UIControlStateNormal];
    _appendButton.translatesAutoresizingMaskIntoConstraints = NO;
    _appendButton.titleLabel.font = [UIFont fontWithName:kAppendButtonFontName size:kAppendButtonFontSize];
    _appendButton.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
    _appendButton.layer.cornerRadius = kAppendButtonCornerRadius;
    [_appendButton setTitleColor:UIColor.labelColor forState:UIControlStateNormal];
    _appendButton.backgroundColor = UIColor.systemGray2Color;
    [_appendButton addTarget:self action:@selector(appendButtonDidTap) forControlEvents:UIControlEventTouchUpInside];
    [_tableFooterView addSubview:_appendButton];
}

#pragma mark - Actions methods

- (void)appendButtonDidTap {
    [_activityIndicatorView startAnimating];
    [self.delegate updateViewWithBeforeId:_listModel.items.lastObject.actionId];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActionsListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[ActionsListItemCell identifier]
                                                                forIndexPath:indexPath];
    [cell updateWithItemModel: _listModel.items[indexPath.item]];
    return cell;
}

@end

NS_ASSUME_NONNULL_END
