//
//  UITableViewCell+Identifier.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 10.11.2021.
//

#import "NSObject+Identifier.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (Identifier)

+ (NSString *)identifier {
    return NSStringFromClass(self.class);
}

@end

NS_ASSUME_NONNULL_END
