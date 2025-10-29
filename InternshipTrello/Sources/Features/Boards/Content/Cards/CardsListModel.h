//
//  CardsListModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import <Foundation/Foundation.h>

#import "CardsListItemModel.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Cards on board.
 */
@interface CardsListModel : NSObject <SerializableModel>

/** Array of cards. */
@property(nonatomic, readonly) NSArray<CardsListItemModel *> *items;

@end

NS_ASSUME_NONNULL_END
