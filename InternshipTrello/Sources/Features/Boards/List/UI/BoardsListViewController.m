//
//  BoardsViewController.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 03.11.2021.
//

#import "BoardsListView.h"
#import "BoardsListViewController.h"
#import "BoardsService.h"
#import "UIViewController+ErrorAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoardsListViewController () <BoardsListViewDelegate>

@end

@implementation BoardsListViewController {
    BoardsListView *_boardsListView;
    BoardsService *_boardsService;
}

#pragma mark - Lifecycle

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringFromTableInBundle(@"boards_screen_title", @"Boards",
                                                        [NSBundle bundleForClass:self.class], @"");
        _boardsService = [[BoardsService alloc] init];
        BoardContentRouter *router = [[BoardContentRouter alloc] initWithViewController:self];
        _boardsListView = [[BoardsListView alloc] initWithRouter:router];
        _boardsListView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self addBoardsListView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViewWithData];
}

#pragma mark - Private methods

- (void)addBoardsListView {
    [self.view addSubview:_boardsListView];
    _boardsListView.translatesAutoresizingMaskIntoConstraints = NO;
    [_boardsListView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [_boardsListView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [_boardsListView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [_boardsListView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
}

- (void)updateViewWithData {
    __weak __typeof__(self) weakSelf = self;
    [_boardsService getCachedBoardsWithUpdatingAndCompletion:^(BoardsListModel * _Nullable model,
                                                               NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof__(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (error) {
                [strongSelf showErrorAlertWithMessage:error.localizedDescription];
            }
            [strongSelf->_boardsListView reloadWithModel:model];
        });
    }];
}

#pragma mark - BoardsListViewDelegate methods

- (void)boardsListViewShouldRefreshData {
    [self updateViewWithData];
}

@end

NS_ASSUME_NONNULL_END
