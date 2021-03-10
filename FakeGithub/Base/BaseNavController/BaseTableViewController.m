//
//  BaseTableViewController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "BaseTableViewController.h"
#import "HomeController.h"
#import "RepoController.h"
#import "DiscoverController.h"
#import "InfoController.h"

@implementation BaseTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // @class HomeController, RepoController, DiscoverController, InfoController;
    // can not figure out how to use @class syntax here
    bool judge = [self isKindOfClass:HomeController.class] || [self isKindOfClass:RepoController.class] || [self isKindOfClass:DiscoverController.class] || [self isKindOfClass:InfoController.class];
    if (judge) {
        self.navigationController.navigationBarHidden = YES;
    } else {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self.navigationController
                                                                      action:@selector(popViewControllerAnimated:)];
        self.navigationItem.leftBarButtonItem = backButton;
    }
}

- (BaseRequest *)request {
    if (!_request) {
        _request = [[BaseRequest alloc] init];
    }
    return _request;
}

@end
