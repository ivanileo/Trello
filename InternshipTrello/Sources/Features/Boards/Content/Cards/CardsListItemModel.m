//
//  CardsListItemModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "CardsListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardsListItemModel

- (instancetype)initWithJSONObject:(nonnull id)json {
    if (![json isKindOfClass:NSDictionary.class]) {
        NSLog(@"Unexpected json object received. Unable to create CardsListItemModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        id cardId = json[@"id"];
        if (![cardId isKindOfClass:NSString.class]) {
            return nil;
        }
        _cardId = cardId;
        id categoryId = json[@"idList"];
        if (![categoryId isKindOfClass:NSString.class]) {
            return nil;
        }
        _categoryId = categoryId;
        id name = json[@"name"];
        if (![name isKindOfClass:NSString.class]) {
            return nil;
        }
        _name = name;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
