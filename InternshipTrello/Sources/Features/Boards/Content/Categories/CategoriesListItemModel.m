//
//  CategoriesListItemModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "CategoriesListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CategoriesListItemModel

- (instancetype)initWithJSONObject:(nonnull id)json {
    if (![json isKindOfClass:NSDictionary.class]) {
        NSLog(@"Unexpected json object received. Unable to create CategoriesListItemModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        _cards = [[NSMutableArray alloc] init];
        id categoryId = json[@"id"];
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
