//
//  BoardsListModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 05.11.2021.
//

#import "BoardsListModel.h"
#import "BoardsListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BoardsListModel

- (instancetype)initWithJSONObject:(id)json {
    if (![json isKindOfClass:NSArray.class]) {
        NSLog(@"Unexpected json object received. Unable to create BoardsListModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (id item in json) {
            [items addObject:[[BoardsListItemModel alloc] initWithJSONObject:item]];
        }
        _items = items;
    }
    return self;
}

- (instancetype)initWithBoards:(nullable NSArray<Board *> *)boards {
    if (!boards) {
        NSLog(@"Null object received. Unable to create BoardsListModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (Board *board in boards) {
            [items addObject:[[BoardsListItemModel alloc] initWithBoard:board]];
        }
        _items = items;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
