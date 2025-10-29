//
//  BoardsListRequest.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 05.11.2021.
//

#import "BoardsListRequest.h"
#import "BoardsListModel.h"

NS_ASSUME_NONNULL_BEGIN

/** URLs. */
static NSString *const kPathURL = @"/1/members/me/boards";

@implementation BoardsListRequest

- (nullable NSString *)path {
    return kPathURL;
}

- (HTTPMethod)requestMethod {
    return GET;
}

- (nullable Class)responseType {
    return BoardsListModel.class;
}

@end

NS_ASSUME_NONNULL_END
