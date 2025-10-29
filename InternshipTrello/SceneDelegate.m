//
//  SceneDelegate.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 04.10.2021.
//

#import <UIKit/UIKit.h>

#import "DeepLinkingURLHandler.h"
#import "MainTabBarController.h"
#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    NSLog(@"app has been called");
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    if (windowScene == nil) {
        return;
    }
    
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    MainTabBarController *mainTabBarController = [[MainTabBarController alloc] init];
    window.rootViewController = mainTabBarController;
    
    self.window = window;
    [window makeKeyAndVisible];
}

- (void)scene:(UIScene *)scene openURLContexts:(nonnull NSSet<UIOpenURLContext *> *)URLContexts {
    NSURL *url = [URLContexts anyObject].URL;
    if (url) {
        NSLog(@"app has been called via URL using deep linking: %@", URLContexts);
        [DeepLinkingURLHandler handleURL:url];
    } else {
        NSLog(@"invalid URL while trying to call the app via URL using deep linking");
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    
}


- (void)sceneWillResignActive:(UIScene *)scene {

}


- (void)sceneWillEnterForeground:(UIScene *)scene {

}


- (void)sceneDidEnterBackground:(UIScene *)scene {

}

@end
