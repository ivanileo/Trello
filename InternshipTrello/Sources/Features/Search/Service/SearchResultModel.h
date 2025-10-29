//
//  SearchResultModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 10.12.2021.
//

#import <Foundation/Foundation.h>

#import "BoardsListModel.h"
#import "CardsListModel.h"
#import "SerializableModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Search results returned to user.
 */
@interface SearchResultModel : NSObject <SerializableModel>

/** Array of cards. */
@property (nonatomic, nullable) CardsListModel *cards;

/** Array of boards. */
@property (nonatomic, nullable) BoardsListModel *boards;

@end

NS_ASSUME_NONNULL_END
