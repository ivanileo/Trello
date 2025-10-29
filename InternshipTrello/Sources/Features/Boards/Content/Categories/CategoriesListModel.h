//
//  CategoriesListModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "CategoriesListItemModel.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Categories on board.
 */
@interface CategoriesListModel : NSObject <SerializableModel>

/** Array of categories. */
@property(nonatomic, readonly) NSArray<CategoriesListItemModel *> *items;

@end

NS_ASSUME_NONNULL_END
