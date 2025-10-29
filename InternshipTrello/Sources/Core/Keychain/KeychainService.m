//
//  KeychainService.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.10.2021.
//

#import "KeychainService.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeychainService ()

@property(nonatomic, readonly) NSString *bundleIdentifier;

@end

@implementation KeychainService

+ (NSString *)bundleIdentifier {
    return [NSBundle.mainBundle bundleIdentifier];
}

+ (void)savePairWithStringValue:(NSString *)value andKey:(NSString *)key {
    NSDictionary<NSString *, NSObject *> *query =
    @{(__bridge NSString *)kSecClass: (__bridge NSString *)kSecClassGenericPassword,
      (__bridge NSString *)kSecAttrAccount: key,
      (__bridge NSString *)kSecAttrService: self.bundleIdentifier,
      (__bridge NSString *)kSecValueData: [value dataUsingEncoding:NSUTF8StringEncoding]};
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    if (status == errSecDuplicateItem) {
        NSLog(@"value with key '%@' already stored, updating...", key);
        [self deleteStringValueByKey:key];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    }
    if (status != errSecSuccess) {
        NSLog(@"unable to store value with key: %@", key);
    } else {
        NSLog(@"successfully stored value with key: %@", key);
    }
}

+ (nullable NSString *)stringValueByKey:(NSString *)key {
    NSDictionary<NSString *, NSObject *> *query =
    @{(__bridge NSString *)kSecClass: (__bridge NSString *)kSecClassGenericPassword,
      (__bridge NSString *)kSecAttrAccount: key,
      (__bridge NSString *)kSecAttrService: self.bundleIdentifier,
      (__bridge NSString *)kSecMatchLimit: (__bridge NSString *)kSecMatchLimitOne,
      (__bridge NSString *)kSecReturnData: @YES};
    CFDataRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                          (CFTypeRef *)&result);
    if (status != errSecSuccess) {
        NSLog(@"unable to get value with key: %@", key);
        return nil;
    }
    NSData *dataResult = (__bridge NSData *)result;
    return [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];
}

+ (void)deleteStringValueByKey:(NSString *)key {
    NSDictionary<NSString *, NSObject *> *query =
    @{(__bridge NSString *)kSecClass: (__bridge NSString *)kSecClassGenericPassword,
      (__bridge NSString *)kSecAttrAccount: key,
      (__bridge NSString *)kSecAttrService: self.bundleIdentifier};
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != errSecSuccess) {
        NSLog(@"unable to delete value with key: %@", key);
    }
}

@end

NS_ASSUME_NONNULL_END
