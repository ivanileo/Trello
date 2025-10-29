//
//  BoardsListItemModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 05.11.2021.
//

#import "BoardsListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BoardsListItemModel

- (instancetype)initWithJSONObject:(id)json {
    if (![json isKindOfClass:NSDictionary.class]) {
        NSLog(@"Unexpected json object received. Unable to create BoardsListItemModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        id boardId = json[@"id"];
        if (![boardId isKindOfClass:NSString.class]) {
            return nil;
        }
        _boardId = boardId;
        id jsonName = json[@"name"];
        if ([jsonName isKindOfClass:NSString.class]) {
            _name = jsonName;
        }
        id jsonPrefs = json[@"prefs"];
        if ([jsonPrefs isKindOfClass:NSDictionary.class]) {
            id backgroundImageUrl = jsonPrefs[@"backgroundImage"];
            if ([backgroundImageUrl isKindOfClass:NSString.class]) {
                _imageUrl = backgroundImageUrl;
            }
        }
    }
    return self;
}

- (instancetype)initWithBoard:(nullable Board *)board {
    if (!board) {
        NSLog(@"Null object received. Unable to create BoardsListItemModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        if (!board.boardId) {
            return nil;
        }
        _boardId = board.boardId;
        if ([board.name isKindOfClass:NSString.class]) {
            _name = board.name;
        }
        if ([board.imageUrl isKindOfClass:NSString.class]) {
            _imageUrl = board.imageUrl;
        }
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
