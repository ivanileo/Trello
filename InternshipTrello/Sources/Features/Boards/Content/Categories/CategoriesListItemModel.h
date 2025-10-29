//
//  CategoriesListItemModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "CardsListItemModel.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Category on board.
 */
@interface CategoriesListItemModel : NSObject <SerializableModel>

/** Id of category. */
@property(nonatomic, readonly) NSString *categoryId;

/** Name of category. */
@property(nonatomic, readonly) NSString *name;

/** Cards in category. */
@property(nonatomic, readonly) NSMutableArray<CardsListItemModel *> *cards;

@end

NS_ASSUME_NONNULL_END
