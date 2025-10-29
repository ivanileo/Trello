//
//  SerializableModel.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 25.10.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A protocol for models that can be initialized with JSON.
 */
@protocol SerializableModel <NSObject>

/**
 * Creates instance using values from object.
 *
 * @param json object with data for creating model.
 */
- (instancetype)initWithJSONObject:(id)json;

@end

NS_ASSUME_NONNULL_END
