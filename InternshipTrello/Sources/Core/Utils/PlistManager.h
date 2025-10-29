//
//  PlistManager.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 26.10.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A class that responsible for reading plists values.
 */
@interface PlistManager : NSObject

/**
 * Returns plist value by plist name and key.
 *
 * @param plistName name of plist.
 * @param key key of value in plist.
 */
+ (nullable NSString *)stringValueByPlistName:(NSString *)plistName andKey:(NSString *)key;

/**
 * Returns dictionary from plist with specific name.
 *
 * @param plistName name of plist.
 */
+ (nullable NSDictionary *)dictionaryFromPListWithName:(NSString *)plistName;

@end

NS_ASSUME_NONNULL_END
