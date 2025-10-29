//
//  SearchViewController.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 13.12.2021.
//

#import "SearchService.h"
#import "SearchView.h"
#import "SearchViewController.h"
#import "UIViewController+ErrorAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController () <SearchViewDelegate>

@end

@implementation SearchViewController {
    SearchView *_searchView;
    SearchService *_searchService;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringFromTable(@"search_title", @"Search", @"");
        _searchService = [[SearchService alloc] init];
        BoardContentRouter *router = [[BoardContentRouter alloc] initWithViewController:self];
        _searchView = [[SearchView alloc] initWithRouter:router];
        _searchView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self addSearchView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_searchView handleAppearing];
}

- (void)addSearchView {
    [self.view addSubview:_searchView];
    _searchView.translatesAutoresizingMaskIntoConstraints = NO;
    [_searchView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [_searchView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [_searchView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [_searchView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
}

- (void)performSearchWithQuery:(NSString *)searchQuery {
    __weak __typeof__(self) weakSelf = self;
    [_searchService searchWithQuery:searchQuery
                      andCompletion:^(SearchResultModel * _Nullable model,
                                      NSString * _Nonnull query,
                                      NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof__(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (error) {
                [strongSelf showErrorAlertWithMessage:error.localizedDescription];
            }
            [strongSelf->_searchView showSearchResultWithModel:model andRequestedQuery:query];
        });
    }];
}

@end

NS_ASSUME_NONNULL_END
