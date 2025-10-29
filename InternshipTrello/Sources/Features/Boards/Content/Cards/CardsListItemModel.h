//
//  CardsListItemModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import <Foundation/Foundation.h>

#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Card on board.
 */
@interface CardsListItemModel : NSObject <SerializableModel>

/** Id of card. */
@property(nonatomic, readonly) NSString *cardId;

/** Id of category. */
@property(nonatomic, readonly) NSString *categoryId;

/** Name of card. */
@property(nonatomic, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END
