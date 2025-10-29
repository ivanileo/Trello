//
//  CategoriesListModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "CategoriesListModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CategoriesListModel

- (instancetype)initWithJSONObject:(nonnull id)json { 
    if (![json isKindOfClass:NSArray.class]) {
        NSLog(@"Unexpected json object received. Unable to create CategoriesListModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (id item in json) {
            [items addObject:[[CategoriesListItemModel alloc] initWithJSONObject:item]];
        }
        _items = items;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
