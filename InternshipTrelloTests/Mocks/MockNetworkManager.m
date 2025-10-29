//
//  MockNetworkManager.m
//  InternshipTrelloTests
//
//  Created by Ivan Suntsov on 12.11.2021.
//

#import "AccountInfoModel.h"
#import "BoardsListModel.h"
#import "MockNetworkManager.h"
#import "NetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MockNetworkManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _receivedRequests = [[NSMutableArray alloc] init];
        _behavior = ShouldReturnValidData;
    }
    return self;
}

- (void)sendRequest:(nonnull id<NetworkRequest>)request withCompletion:(nonnull RequestCompletion)completion {
    [self.receivedRequests addObject:request];
    Class responseType = request.responseType;
    if ([responseType conformsToProtocol:@protocol(SerializableModel)]) {
        switch (self.behavior) {
            case ShouldReturnValidData: {
                NSURL *url = [[NSBundle bundleForClass:self.class] URLForResource:NSStringFromClass(responseType)
                                                                    withExtension:@"json"];
                id<SerializableModel> object = [[responseType alloc] initWithJSONObject:[NSJSONSerialization
                                                                                         JSONObjectWithData:[NSData dataWithContentsOfURL:url]
                                                                                         options:0
                                                                                         error:nil]];
                completion(object, nil);
                break;
            }
            case ShouldReturnError: {
                NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : @"Error occured in mocked NetworkManager!" };
                NSError *error = [NSError errorWithDomain:@"MockNetworkManagerErrorDomain"
                                                     code:0
                                                 userInfo:userInfo];
                completion(nil, error);
                break;
            }
        }
    } else {
        completion(nil, nil);
    }
}

@end

NS_ASSUME_NONNULL_END
