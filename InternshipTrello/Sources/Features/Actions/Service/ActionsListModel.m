//
//  ActionsListModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.12.2021.
//

#import "ActionsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ActionsListModel

- (instancetype)initWithJSONObject:(nonnull id)json {
    if (![json isKindOfClass:NSArray.class]) {
        NSLog(@"Unexpected json object received. Unable to create BoardsListModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (id item in json) {
            [items addObject:[[ActionsListItemModel alloc] initWithJSONObject:item]];
        }
        _items = items;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
