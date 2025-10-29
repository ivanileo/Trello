//
//  BoardContentViewController.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 23.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A view controller for board's content.
 */
@interface BoardContentViewController : UIViewController

/**
 * Creates view controller with specific requested board id.
 *
 * @param boardId id of board that will be requested to show.
 */
- (instancetype)initWithBoardId:(NSString *)boardId;

@end

NS_ASSUME_NONNULL_END
