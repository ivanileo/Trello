//
//  ActionsListItemModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.12.2021.
//

#import "ActionsListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ActionsListItemModel

- (instancetype)initWithJSONObject:(nonnull id)json {
    if (![json isKindOfClass:NSDictionary.class]) {
        NSLog(@"Unexpected json object received. Unable to create BoardsListItemModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        id actionId = json[@"id"];
        if (![actionId isKindOfClass:NSString.class]) {
            return nil;
        }
        _actionId = actionId;
        id date = json[@"date"];
        if (![date isKindOfClass:NSString.class]) {
            return nil;
        }
        _date = date;
        id type = json[@"type"];
        if (![type isKindOfClass:NSString.class]) {
            return nil;
        }
        _type = type;
        id username = json[@"memberCreator"][@"username"];
        if (![username isKindOfClass:NSString.class]) {
            return nil;
        }
        _username = username;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
