//
//  BoardCategoriesRequest.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.11.2021.
//

#import "BoardCategoriesRequest.h"
#import "CategoriesListModel.h"

NS_ASSUME_NONNULL_BEGIN

/** URLs. */
static NSString *const kPathURL = @"/lists";

@implementation BoardCategoriesRequest

- (nullable NSString *)path {
    return [[super path] stringByAppendingPathComponent:kPathURL];
}

- (nullable Class)responseType {
    return CategoriesListModel.class;
}

@end

NS_ASSUME_NONNULL_END
