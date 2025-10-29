//
//  PlistManager.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 26.10.2021.
//

#import "PlistManager.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlistManager

+ (nullable NSString *)stringValueByPlistName:(NSString *)plistName andKey:(NSString *)key {
    NSURL *url = [NSBundle.mainBundle URLForResource:plistName withExtension:@"plist"];
    NSDictionary<NSString *, NSString *> *dict = [NSDictionary dictionaryWithContentsOfURL:url];
    if (!dict) {
        NSLog(@"unable to read plist file with name: %@", plistName);
        return nil;
    }
    return dict[key];
}

+ (nullable NSDictionary *)dictionaryFromPListWithName:(NSString *)plistName {
    NSURL *url = [NSBundle.mainBundle URLForResource:plistName withExtension:@"plist"];
    NSDictionary<NSString *, NSString *> *dict = [NSDictionary dictionaryWithContentsOfURL:url];
    if (!dict) {
        NSLog(@"unable to read plist file with name: %@", plistName);
        return nil;
    }
    return dict;
}

@end

NS_ASSUME_NONNULL_END
