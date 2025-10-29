//
//  ActionsListViewController.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 07.12.2021.
//

#import "ActionsListView.h"
#import "ActionsListViewController.h"
#import "ActionsService.h"
#import "UIViewController+ErrorAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActionsListViewController () <ActionsListViewDelegate>

@end

@implementation ActionsListViewController {
    ActionsListView *_actionsListView;
    ActionsService *_actionsService;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _actionsService = [[ActionsService alloc] init];
        _actionsListView = [[ActionsListView alloc] init];
        _actionsListView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self addActionsListView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViewWithBeforeId:nil];
}

- (void)addActionsListView {
    [self.view addSubview:_actionsListView];
    _actionsListView.translatesAutoresizingMaskIntoConstraints = NO;
    [_actionsListView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [_actionsListView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [_actionsListView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [_actionsListView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
}

- (void)updateViewWithBeforeId:(nullable NSString *)beforeId {
    __weak __typeof__(self) weakSelf = self;
    [_actionsService getActionsListWithBeforeActionId:beforeId
                                        andCompletion:^(ActionsListModel * _Nullable model,
                                                        NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof__(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (error) {
                [strongSelf showErrorAlertWithMessage:error.localizedDescription];
            }
            if (beforeId) {
                [strongSelf->_actionsListView appendListWithModel:model];
            } else {
                [strongSelf->_actionsListView reloadWithModel:model];
            }
        });
    }];
}

@end

NS_ASSUME_NONNULL_END
