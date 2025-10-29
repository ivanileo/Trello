//
//  ActionsListRequest.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.12.2021.
//

#import "ActionsListModel.h"
#import "ActionsListRequest.h"

NS_ASSUME_NONNULL_BEGIN

/** URLs. */
static NSString *const kPathURL = @"/1/members/me/actions";

@implementation ActionsListRequest

- (nullable NSString *)path {
    return kPathURL;
}

- (HTTPMethod)requestMethod {
    return GET;
}

- (nullable NSDictionary<NSString *,NSString *> *)query {
    NSMutableDictionary<NSString *,NSString *> *resultQuery = [NSMutableDictionary
                                                               dictionaryWithDictionary:[super query]];
    if (_beforeId) {
        resultQuery[@"before"] = _beforeId;
    }
    if (_limit != 0) {
        resultQuery[@"limit"] = [@(_limit) stringValue];
    }
    return resultQuery;
}

- (nullable Class)responseType {
    return ActionsListModel.class;
}

@end

NS_ASSUME_NONNULL_END
