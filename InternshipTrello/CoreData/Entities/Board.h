//
//  Board.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 29.12.2021.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Board class to save in CoreData.
 */
@interface Board : NSManagedObject

/** Id of board. */
@property (nonatomic) NSString *boardId;

/** Name of board. */
@property (nonatomic) NSString *name;

/** Image URL of board. */
@property (nonatomic) NSString *imageUrl;

@end

NS_ASSUME_NONNULL_END
