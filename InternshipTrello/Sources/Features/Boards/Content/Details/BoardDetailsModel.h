//
//  BoardDetailsModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 18.11.2021.
//

#import <Foundation/Foundation.h>

#import "CategoriesListModel.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Board details.
 */
@interface BoardDetailsModel : NSObject <SerializableModel>

/** Id of board. */
@property(nonatomic, readonly) NSString *boardId;

/** Name of board. */
@property(nonatomic, readonly) NSString *name;

/** Description of board. */
@property(nonatomic, readonly, nullable) NSString *desc;

/** Url of board. */
@property(nonatomic, readonly) NSString *url;

/** Categories on board. */
@property(nonatomic, nullable) CategoriesListModel *categories;

@end

NS_ASSUME_NONNULL_END
