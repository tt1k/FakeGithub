//
//  MainTabBarController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "MainTabBarController.h"
#import "HomeController.h"
#import "RepoController.h"
#import "DiscoverController.h"
#import "InfoController.h"
#import "BaseNavigationController.h"

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTabBarItems];
}

- (void)loadTabBarItems {
    HomeController *homeVC = [[HomeController alloc] init];
    [self addTabBarItemWithController:homeVC andNormalImage:@"Home" andSelectedImage:@"Home" andBarTitle:@"Home"];
    RepoController *repoVC = [[RepoController alloc] init];
    [self addTabBarItemWithController:repoVC andNormalImage:@"Repo" andSelectedImage:@"Repo" andBarTitle:@"Repo"];
    DiscoverController *discoverVC = [[DiscoverController alloc] init];
    [self addTabBarItemWithController:discoverVC andNormalImage:@"Discover" andSelectedImage:@"Discover" andBarTitle:@"Discover"];
    InfoController *infoVC = [[InfoController alloc] init];
    [self addTabBarItemWithController:infoVC andNormalImage:@"Info" andSelectedImage:@"Info" andBarTitle:@"Info"];
}

- (void)addTabBarItemWithController:(UIViewController *)viewController andNormalImage:(NSString *)normalImage andSelectedImage:(NSString *)selectedImage andBarTitle:(NSString *)barTitle {
    // config viewController
    viewController.title = barTitle;
    viewController.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSDictionary<NSAttributedStringKey, id> *stateControlAttr = @{NSForegroundColorAttributeName:UIColor.blackColor, NSFontAttributeName:[UIFont systemFontOfSize:12.0f]};
    [viewController.tabBarItem setTitleTextAttributes:stateControlAttr forState:UIControlStateNormal];
    NSDictionary<NSAttributedStringKey, id> *stateSelectedAttr = @{NSForegroundColorAttributeName:UIColor.blueColor, NSFontAttributeName:[UIFont systemFontOfSize:12.0f]};
    [viewController.tabBarItem setTitleTextAttributes:stateSelectedAttr forState:UIControlStateSelected];
    
    // using customized BaseNavigationController to wrap configed viewController
    BaseNavigationController *baseNavVC = [[BaseNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:baseNavVC];
}



@end
