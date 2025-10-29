//
//  BoardContentRouter.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 23.11.2021.
//

#import "BoardContentViewController.h"
#import "BoardContentRouter.h"

#import "AccountViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BoardContentRouter {
    __weak UIViewController *_context;
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _context = viewController;
    }
    return self;
}

- (void)showBoardContentWithBoardId:(NSString *)boardId {
    [_context.navigationController pushViewController:[[BoardContentViewController alloc] initWithBoardId:boardId]
                                             animated:YES];
}

@end

NS_ASSUME_NONNULL_END
