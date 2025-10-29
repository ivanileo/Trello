//
//  AccountInfoModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.10.2021.
//

#import "AccountInfoModel.h"

@implementation AccountInfoModel

- (instancetype)initWithJSONObject:(id)json {
    if (![json isKindOfClass:NSDictionary.class]) {
        NSLog(@"Unexpected json object received. Unable to create AccountInfoModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        id fullName = json[@"fullName"];
        if ([fullName isKindOfClass:NSString.class]) {
            _fullName = fullName;
        }
        id username = json[@"username"];
        if ([username isKindOfClass:NSString.class]) {
            _username = username;
        }
        id initials = json[@"initials"];
        if ([initials isKindOfClass:NSString.class]) {
            _initials = initials;
        }
        id url = json[@"url"];
        if ([url isKindOfClass:NSString.class]) {
            _url = url;
        }
        id avatarUrl = json[@"avatarUrl"];
        if ([avatarUrl isKindOfClass:NSString.class]) {
            _avatarUrl = [NSString stringWithFormat:@"%@/original.png", avatarUrl];
        }
    }
    return self;
}

@end
