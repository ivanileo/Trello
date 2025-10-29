//
//  KeychainService.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.10.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A class that performs add/get/delete operations with keychain. 
 */
@interface KeychainService : NSObject

/**
 * Saves string value in keychain with specific key.
 *
 * @param value string value that will be stored.
 * @param key unique key that provides access to value.
 */
+ (void)savePairWithStringValue:(NSString *)value andKey:(NSString *)key;

/**
 * Returns string value by key.
 *
 * @param key unique key that provides access to value.
 */
+ (nullable NSString *)stringValueByKey:(NSString *)key;

/**
 * Deletes string value by key.
 *
 * @param key unique key that provides access to value.
 */
+ (void)deleteStringValueByKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
