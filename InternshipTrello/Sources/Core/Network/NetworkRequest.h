//
//  NetworkRequest.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 22.10.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A enumeration for types of http request methods.
 */
typedef NS_ENUM(NSInteger, HTTPMethod) {
    GET,
    POST,
    PUT,
    DELETE
};

/**
 * A protocol that declares required fields for the generic network request.
 */
@protocol NetworkRequest <NSObject>

/**
 * Full url for request.
 */
@property(nonatomic, readonly) NSString *url;

/**
 * Path url part for request.
 */
@property(nonatomic, readonly, nullable) NSString *path;

/**
 * Parameters for request.
 */
@property(nonatomic, readonly, nullable) NSDictionary<NSString *, NSString *> *query;

/**
 * Headers for request.
 */
@property(nonatomic, readonly, nullable) NSDictionary<NSString *, NSString *> *headers;

/**
 * Body for request.
 */
@property(nonatomic, readonly, nullable) NSData *body;

/**
 * Method for request (GET, POST etc.)
 */
@property(nonatomic, readonly) HTTPMethod requestMethod;

/**
 * Type of object that should be returned to completion block.
 * This type must conform protocol SerializableModel.
 */
@property(nonatomic, readonly, nullable) Class responseType;

@end

NS_ASSUME_NONNULL_END
