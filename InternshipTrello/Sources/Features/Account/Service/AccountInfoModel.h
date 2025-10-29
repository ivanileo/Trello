//
//  AccountInfoModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.10.2021.
//

#import <Foundation/Foundation.h>

#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Information about user account.
 */
@interface AccountInfoModel : NSObject <SerializableModel>

/** Full name of user. */
@property(nonatomic, readonly, nullable) NSString *fullName;

/** Username of user. */
@property(nonatomic, readonly, nullable) NSString *username;

/** Initials of user. */
@property(nonatomic, readonly, nullable) NSString *initials;

/** URL in Trello network of user. */
@property(nonatomic, readonly, nullable) NSString *url;

/** URL with avatar of user. */
@property(nonatomic, readonly, nullable) NSString *avatarUrl;

@end

NS_ASSUME_NONNULL_END
