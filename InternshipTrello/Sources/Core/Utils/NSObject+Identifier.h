//
//  UITableViewCell+Identifier.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 10.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A category that extends NSObject for accessing class identifier as NSString.
 */
@interface NSObject (Identifier)

/**
 * Returns identifier of class as string value.
 */
+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
