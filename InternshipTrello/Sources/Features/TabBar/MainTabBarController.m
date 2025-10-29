//
//  MainTabBarController.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 03.11.2021.
//

#import "AccountService.h"
#import "AccountViewController.h"
#import "ActionsListViewController.h"
#import "BoardsListViewController.h"
#import "InternshipTrello-Swift.h"
#import "MainTabBarController.h"
#import "SearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Constants

/** Tab bar item consts. */
static NSUInteger kTabItemsCount = 4;

/** Localizable table with strings const. */
static NSString *const kTabBarTableName = @"TabBar";

#pragma mark - Enum functions

/** Tab bar item enum. */
typedef NS_ENUM (NSUInteger, TabItem) {
    TabItemBoards,
    TabItemActions,
    TabItemSearch,
    TabItemAccount
};

NSString *TitleForTabItem(TabItem item) {
    NSBundle *bundle = [NSBundle bundleForClass:MainTabBarController.class];
    switch (item) {
        case TabItemBoards:
            return NSLocalizedStringFromTableInBundle(@"boards_item_title", kTabBarTableName, bundle, @"");
        case TabItemActions:
            return NSLocalizedStringFromTableInBundle(@"actions_item_title", kTabBarTableName, bundle, @"");
        case TabItemSearch:
            return NSLocalizedStringFromTableInBundle(@"search_item_title", kTabBarTableName, bundle, @"");
        case TabItemAccount:
            return NSLocalizedStringFromTableInBundle(@"account_item_title", kTabBarTableName, bundle, @"");
    }
}

UIImage *ImageForTabItem(TabItem item) {
    switch (item) {
        case TabItemBoards:
            return [UIImage systemImageNamed:@"list.bullet.rectangle"];
        case TabItemActions:
            return [UIImage systemImageNamed:@"pencil"];
        case TabItemSearch:
            return [UIImage systemImageNamed:@"magnifyingglass"];
        case TabItemAccount:
            return [UIImage systemImageNamed:@"person"];
    }
}

UIViewController *ViewControllerForTabItem(TabItem item) {
    switch (item) {
        case TabItemBoards: {
            BoardsListViewController *boardsListViewController = [[BoardsListViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc]
                                                            initWithRootViewController:boardsListViewController];
            return navigationController;
        }
        case TabItemActions:
            return [[ActionsListViewController alloc] init];
        case TabItemSearch: {
            SearchViewController *searchViewController = [[SearchViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc]
                                                            initWithRootViewController:searchViewController];
            return navigationController;
        }
        case TabItemAccount:
            return [[AccountViewController alloc] init];
    }
}

@implementation MainTabBarController

#pragma mark - Lifecycle

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createViewControllers];
        [self configureUIByAuthorizedStatus:AuthorizationService.isAuthorized];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(receiveLoginNotification:)
                                                   name:kLoginNotification
                                                 object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(receiveLogoutNotification:)
                                                   name:kLogoutNotification
                                                 object:nil];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureUIByAuthorizedStatus:AuthorizationService.isAuthorized];
}

#pragma mark - Private methods

- (void)configureUIByAuthorizedStatus:(BOOL)isAuthorized {
    self.selectedIndex = isAuthorized ? TabItemBoards : TabItemAccount;
    [self setTabBarEnabled:isAuthorized];
}

- (void)createViewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSUInteger tabItem = 0; tabItem < kTabItemsCount; tabItem++) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:TitleForTabItem(tabItem)
                                                                 image:ImageForTabItem(tabItem)
                                                                   tag:tabItem];
        UIViewController *viewController = ViewControllerForTabItem(tabItem);
        viewController.tabBarItem = tabBarItem;
        [viewControllers addObject:viewController];
    }
    self.viewControllers = viewControllers;
}

- (void)setTabBarEnabled:(BOOL)enabled {
    for (UIViewController *viewController in self.viewControllers) {
        viewController.tabBarItem.enabled = enabled;
    }
    self.selectedViewController.tabBarItem.enabled = YES;
}

#pragma mark - Notifications handlers

- (void)receiveLoginNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:kLoginNotification]) {
        [self setTabBarEnabled:YES];
    }
}

- (void)receiveLogoutNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:kLogoutNotification]) {
        [self setTabBarEnabled:NO];
    }
}

@end

NS_ASSUME_NONNULL_END
