//
//  ActionsListModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.12.2021.
//

#import <Foundation/Foundation.h>

#import "ActionsListItemModel.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Actions performed by user.
 */
@interface ActionsListModel : NSObject <SerializableModel>

/** Array of actions. */
@property(nonatomic, readonly) NSMutableArray<ActionsListItemModel *> *items;

@end

NS_ASSUME_NONNULL_END
