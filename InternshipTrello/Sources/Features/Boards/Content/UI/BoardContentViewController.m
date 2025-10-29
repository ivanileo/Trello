//
//  BoardContentViewController.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 23.11.2021.
//

#import "BoardContentView.h"
#import "BoardContentViewController.h"
#import "BoardsService.h"
#import "UIViewController+ErrorAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoardContentViewController () <BoardContentViewDelegate>

@end

@implementation BoardContentViewController {
    BoardsService *_boardsService;
    BoardContentView *_boardContentView;
    NSString *_boardId;
}

- (instancetype)initWithBoardId:(NSString *)boardId {
    self = [super init];
    if (self) {
        _boardId = boardId;
        _boardsService = [[BoardsService alloc] init];
        _boardContentView = [[BoardContentView alloc] init];
        _boardContentView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBoardContentView];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViewWithData];
}

- (void)addBoardContentView {
    [self.view addSubview:_boardContentView];
    _boardContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [_boardContentView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [_boardContentView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [_boardContentView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [_boardContentView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
}

- (void)updateViewWithData {
    __weak __typeof__(self) weakSelf = self;
    [_boardsService getBoardContentWithBoardId:_boardId
                                 andCompletion:^(BoardDetailsModel * _Nullable model,
                                                 NSArray<NSError *> * _Nullable errors) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof__(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (errors) {
                NSMutableArray<NSString *> *descriptions = [[NSMutableArray alloc] init];
                for (NSError *error in errors) {
                    [descriptions addObject:error.localizedDescription];
                }
                [self showErrorAlertWithMessage:[descriptions componentsJoinedByString:@"\n"]];
            }
            strongSelf.title = model.name;
            [strongSelf->_boardContentView reloadWithModel:model];
        });
    }];
}

- (void)boardsContentViewShouldRefreshData {
    [self updateViewWithData];
}

@end

NS_ASSUME_NONNULL_END
