//
//  DeepLinkingURLHandler.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 11.10.2021.
//

#import "DeepLinkingURLHandler.h"
#import "InternshipTrello-Swift.h"

NS_ASSUME_NONNULL_BEGIN

/** Host for authorization url. */
static NSString *const kAuthHost = @"auth";

@implementation DeepLinkingURLHandler

+ (void)handleURL:(NSURL *)url {
    if ([kAuthHost isEqualToString:url.host]) {
        NSLog(@"authorization url handling...");
        [AuthorizationService handleOAuthURL:url];
    } else {
        NSLog(@"unrecognized URL while trying to call the app via URL using deep linking");
    }
}

@end

NS_ASSUME_NONNULL_END
