//
//  RepoListViewController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/12.
//

#import <Foundation/Foundation.h>

#import "RepoListViewController.h"
#import "BaseDomain.h"
#import "FollowModel.h"
#import "RepoModel.h"
#import "OrgModel.h"
#import "GistModel.h"
#import "ProjectModel.h"

@interface RepoListViewController()

@property (strong, nonatomic) NSMutableArray<id> *resourceList;
@property (assign, nonatomic) GithubResourceType resourceType;

@end

@implementation RepoListViewController

static NSString *reusedIdentifier = @"repoListViewCell";

#pragma mark UIViewController LifeCycle

- (instancetype)initWithDataType:(GithubResourceType)resourceType {
    // override init method to customize TableView style setting
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _resourceType = resourceType;
        [self githubLoadresourceList];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetting];
}

# pragma mark Logic Layer

- (void)initSetting {
    // init resourceList
    _resourceList = [[NSMutableArray<id> alloc] init];
}

- (void)githubLoadresourceList {
    __weak typeof(self) weakSelf = self;
    [self.request getWithResourceType:_resourceType andParams:nil andBlock:^(id response) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in responseDict) {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
            switch (weakSelf.resourceType) {
                case GithubResourceFollowing:
                case GithubResourceFollowers: {
                    FollowModel *followingModel = FollowModelFromData(data, &error);
                    [weakSelf.resourceList addObject:followingModel];
                    break;
                }
                case GithubResourceOrganizations: {
                    OrgModel *orgModel = OrgModelFromData(data, &error);
                    [weakSelf.resourceList addObject:orgModel];
                    break;
                }
                case GithubResourceRepositories:
                case GithubResourceStars: {
                    RepoModel *repoModel = RepoModelFromData(data, &error);
                    [weakSelf.resourceList addObject:repoModel];
                    break;
                }
                case GithubResourceProjects: {
                    ProjectModel *projectModel = ProjectModelFromData(data, &error);
                    [weakSelf.resourceList addObject:projectModel];
                    break;
                }
                case GithubResourceGists: {
                    GistModel *gistModel = GistModelFromData(data, &error);
                    [weakSelf.resourceList addObject:gistModel];
                    break;
                }
                case GithubResourceUser:
                case GithubResourceTrending:
                case GithubResourceCollections:
                case GithubResourceFeed:
                case GithubResourceAccessToken:
                    break;
            }
        };
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resourceList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *followingCell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (!followingCell) {
        followingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedIdentifier];
    }
    followingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    followingCell.textLabel.text = [NSString stringWithFormat:@"num: %ld", (long)indexPath.row];
    followingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    followingCell.imageView.image = [UIImage imageNamed:@"Home"];
    return followingCell;
}

@end
