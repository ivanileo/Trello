//
//  CardsListModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "CardsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardsListModel

- (instancetype)initWithJSONObject:(nonnull id)json {
    if (![json isKindOfClass:NSArray.class]) {
        NSLog(@"Unexpected json object received. Unable to create CardsListModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (id item in json) {
            [items addObject:[[CardsListItemModel alloc] initWithJSONObject:item]];
        }
        _items = items;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
