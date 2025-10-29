//
//  DeepLinkingURLHandler.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 11.10.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A class that performs in-app action based on the deeplink URL.
 */
@interface DeepLinkingURLHandler : NSObject

/**
 * Performs a required action for a deeplink URL.
 *
 * @param url The URL to handle.
 */
+ (void)handleURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
