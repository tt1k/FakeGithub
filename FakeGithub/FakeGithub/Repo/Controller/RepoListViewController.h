//
//  RepoListViewController.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/12.
//

#import <UIKit/UIKit.h>

#import "BaseTableViewController.h"
#import "BaseDomain.h"

@interface RepoListViewController : BaseTableViewController

- (instancetype)initWithDataType:(GithubResourceType)resourceType;

@end
