//
//  ActionsService.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.12.2021.
//

#import "ActionsListRequest.h"
#import "ActionsService.h"
#import "NetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

/** Actions list request limit const. */
static const NSUInteger kActionsLimit = 10;

@implementation ActionsService {
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

- (void)getActionsListWithBeforeActionId:(nullable NSString *)actionId
                           andCompletion:(ActionsListCompletion)completion {
    ActionsListRequest *actionsListRequest = [[ActionsListRequest alloc] init];
    actionsListRequest.beforeId = actionId;
    actionsListRequest.limit = kActionsLimit;
    [_networkManager sendRequest:actionsListRequest
                  withCompletion:^(id<SerializableModel> _Nullable model, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            completion(nil, error);
            return;
        }
        completion(model, nil);
    }];
}

@end

NS_ASSUME_NONNULL_END
