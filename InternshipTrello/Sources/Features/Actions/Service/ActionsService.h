//
//  ActionsService.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 01.12.2021.
//

#import <Foundation/Foundation.h>

#import "ActionsListModel.h"
#import "NetworkManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/** Type of completion block for handling actions list model result. */
typedef void (^ActionsListCompletion)(ActionsListModel * _Nullable,  NSError * _Nullable);

/**
 * Performs actions for fetching lists of user's actions to show.
 */
@interface ActionsService : NSObject

/**
 * Creates ActionsService with specific NetworkNamagerProtocol object.
 *
 * @param networkManager object that conforms protocol NetworkManagerProtocol.
 */
- (instancetype)initWithNetworkManager:(id<NetworkManagerProtocol>)networkManager;

/**
 * Returns list of actions for current user or error in completion block.
 *
 * @param actionId last action that was displayed in list. Used for pagination.
 * @param completion completion block to handle result or error.
 */
- (void)getActionsListWithBeforeActionId:(nullable NSString *)actionId
                           andCompletion:(ActionsListCompletion)completion;

@end

NS_ASSUME_NONNULL_END
