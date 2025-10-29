//
//  BoardsListItemModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 05.11.2021.
//

#import <Foundation/Foundation.h>

#import "Board.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Item for list of user's boards.
 */
@interface BoardsListItemModel : NSObject <SerializableModel>

/** Name of board. */
@property(nonatomic, readonly, nullable) NSString *name;

/** Id of board. */
@property(nonatomic, readonly) NSString *boardId;

/** Image URL of board. */
@property(nonatomic, readonly, nullable) NSString *imageUrl;

/**
 * Creates instance using values from CoreData object.
 *
 * @param board object with data for creating model.
 */
- (instancetype)initWithBoard:(nullable Board *)board;

@end

NS_ASSUME_NONNULL_END
