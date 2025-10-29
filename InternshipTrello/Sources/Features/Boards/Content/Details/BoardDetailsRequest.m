//
//  BoardDetailsRequest.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 18.11.2021.
//

#import "BoardDetailsModel.h"
#import "BoardDetailsRequest.h"

NS_ASSUME_NONNULL_BEGIN

/** URLs. */
static NSString *const kPathURL = @"/1/boards/";

@implementation BoardDetailsRequest

- (nullable NSString *)path {
    return _boardId ? [kPathURL stringByAppendingPathComponent:_boardId] : kPathURL;
}

- (HTTPMethod)requestMethod {
    return GET;
}

- (nullable Class)responseType {
    return BoardDetailsModel.class;
}

@end

NS_ASSUME_NONNULL_END
