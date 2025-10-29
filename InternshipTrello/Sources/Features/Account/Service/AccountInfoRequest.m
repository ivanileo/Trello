//
//  AccountRequest.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.10.2021.
//

#import "AccountInfoModel.h"
#import "AccountInfoRequest.h"

NS_ASSUME_NONNULL_BEGIN

/** URLs. */
static NSString *const kPathURL = @"/1/members/me";

@implementation AccountInfoRequest

- (nullable NSString *)path {
    return kPathURL;
}

- (HTTPMethod)requestMethod {
    return GET;
}

- (nullable Class)responseType {
    return AccountInfoModel.class;
}

@end

NS_ASSUME_NONNULL_END
