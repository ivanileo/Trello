//
//  BoardDetailsModel.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 18.11.2021.
//

#import "BoardDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BoardDetailsModel

- (instancetype)initWithJSONObject:(id)json {
    if (![json isKindOfClass:NSDictionary.class]) {
        NSLog(@"Unexpected json object received. Unable to create BoardDetailsModel model.");
        return nil;
    }
    self = [super init];
    if (self) {
        id boardId = json[@"id"];
        if (![boardId isKindOfClass:NSString.class]) {
            return nil;
        }
        _boardId = boardId;
        id name = json[@"name"];
        if (![name isKindOfClass:NSString.class]) {
            return nil;
        }
        _name = name;
        id desc = json[@"desc"];
        if ([desc isKindOfClass:NSString.class]) {
            _desc = desc;
        }
        id url = json[@"url"];
        if (![url isKindOfClass:NSString.class]) {
            return nil;
        }
        _url = url;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
