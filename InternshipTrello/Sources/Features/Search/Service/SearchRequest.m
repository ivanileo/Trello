//
//  SearchRequest.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 09.12.2021.
//

#import "SearchRequest.h"
#import "SearchResultModel.h"

NS_ASSUME_NONNULL_BEGIN

/** URLs. */
static NSString *const kPathURL = @"/1/search";

@implementation SearchRequest

- (nullable NSString *)path {
    return kPathURL;
}

- (HTTPMethod)requestMethod {
    return GET;
}

- (nullable NSDictionary<NSString *,NSString *> *)query {
    NSMutableDictionary<NSString *,NSString *> *resultQuery = [NSMutableDictionary
                                                               dictionaryWithDictionary:[super query]];
    resultQuery[@"query"] = _searchQuery;
    resultQuery[@"partial"] = @"true";
    return resultQuery;
}

- (nullable Class)responseType {
    return SearchResultModel.class;
}

@end

NS_ASSUME_NONNULL_END
