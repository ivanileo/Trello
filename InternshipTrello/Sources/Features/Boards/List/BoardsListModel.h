//
//  BoardsListModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 05.11.2021.
//

#import "Board.h"
#import "BoardsListItemModel.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * List of user's boards.
 */
@interface BoardsListModel : NSObject <SerializableModel>

/** Array of boards. */
@property(nonatomic, readonly) NSArray<BoardsListItemModel *> *items;

/**
 * Creates instance using values from CoreData objects.
 *
 * @param boards objects with data for creating model.
 */
- (instancetype)initWithBoards:(nullable NSArray<Board *> *)boards;

@end

NS_ASSUME_NONNULL_END
