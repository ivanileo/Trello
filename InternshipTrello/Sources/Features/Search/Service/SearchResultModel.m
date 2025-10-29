//
//  SearchResultModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 10.12.2021.
//

#import "SearchResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SearchResultModel

- (instancetype)initWithJSONObject:(nonnull id)json {
    if (![json isKindOfClass:NSDictionary.class]) {
        NSLog(@"Unexpected json object received. Unable to create SearchResultModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        _boards = [[BoardsListModel alloc] initWithJSONObject:json[@"boards"]];
        _cards = [[CardsListModel alloc] initWithJSONObject:json[@"cards"]];
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
