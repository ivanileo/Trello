//
//  BoardContentRouter.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 23.11.2021.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Router for showing boards via board id.
 */
@interface BoardContentRouter : NSObject

/**
 * Creates router with specific root view controller.
 *
 * @param viewController root view controller.
 */
- (instancetype)initWithViewController:(UIViewController *)viewController;

/**
 * Pushes board content view controller to navigation stack of root view controller.
 *
 * @param boardId id of board that will showed.
 */
- (void)showBoardContentWithBoardId:(NSString *)boardId;

@end

NS_ASSUME_NONNULL_END
