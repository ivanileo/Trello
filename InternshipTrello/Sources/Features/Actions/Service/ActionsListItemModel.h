//
//  ActionsListItemModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.12.2021.
//

#import <Foundation/Foundation.h>

#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Action performed by user.
 */
@interface ActionsListItemModel : NSObject <SerializableModel>

/** Id of actions. */
@property(nonatomic, readonly) NSString *actionId;

/** Date of actions. */
@property(nonatomic, readonly) NSString *date;

/** Type of actions. */
@property(nonatomic, readonly) NSString *type;

/** Username that performed action. */
@property(nonatomic, readonly) NSString *username;

@end

NS_ASSUME_NONNULL_END
