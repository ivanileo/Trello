//
//  BoardCardsRequest.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "BoardCardsRequest.h"
#import "CardsListModel.h"

NS_ASSUME_NONNULL_BEGIN

/** URLs. */
static NSString *const kPathURL = @"/cards";

@implementation BoardCardsRequest

- (nullable NSString *)path {
    return [[super path] stringByAppendingPathComponent:kPathURL];
}

- (nullable Class)responseType {
    return CardsListModel.class;
}

@end

NS_ASSUME_NONNULL_END
