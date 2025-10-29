//
//  SearchService.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 09.12.2021.
//

#import "NetworkManager.h"
#import "SearchRequest.h"
#import "SearchService.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SearchService {
    id<NetworkManagerProtocol> _networkManager;
}

- (instancetype)init {
    return [self initWithNetworkManager:NetworkManager.shared];
}

- (instancetype)initWithNetworkManager:(id<NetworkManagerProtocol>)networkManager {
    self = [super init];
    if (self) {
        _networkManager = networkManager;
    }
    return self;
}

- (void)searchWithQuery:(NSString *)query andCompletion:(SearchResultCompletion)completion {
    SearchRequest *request = [[SearchRequest alloc] init];
    request.searchQuery = query;
    [_networkManager sendRequest:request withCompletion:^(id<SerializableModel> _Nullable model,
                                                          NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            completion(nil, query, error);
            return;
        }
        completion(model, query, nil);
    }];
}

@end

NS_ASSUME_NONNULL_END
