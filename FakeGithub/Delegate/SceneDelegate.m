//
//  SceneDelegate.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/8.
//

#import "SceneDelegate.h"
#import "MainTabBarController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // initialize main UINavigationController
    UITabBarController *mainTabBarVC = [[MainTabBarController alloc] init];
    
    // config window property
    _window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    _window.backgroundColor = UIColor.whiteColor;
    _window.rootViewController = mainTabBarVC;
    [_window makeKeyAndVisible];
}

@end
