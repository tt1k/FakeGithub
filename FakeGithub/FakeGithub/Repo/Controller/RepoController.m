//
//  RepoController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/8.
//

#import <Foundation/Foundation.h>

#import "RepoController.h"
#import "RepoListViewController.h"

@interface RepoController()

@property (strong, nonatomic) NSMutableArray *repoMenus;

@end

@implementation RepoController

static NSString *reusedIdentifier = @"repoCell";

- (instancetype)init {
    // override init method to customize TableView style setting
    self = [super initWithStyle:UITableViewStyleInsetGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetting];
}

- (void)initSetting {
    // init repoMenus
    _repoMenus = [[NSMutableArray alloc] init];
    
    // repo section
    [_repoMenus addObject:@[@"Repositories", @"Organizations", @"Projects", @"Gists", @"Stars"]];
    
    // relation section
    [_repoMenus addObject:@[@"Following", @"Followers"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *repoMenu = _repoMenus[section];
    return repoMenu.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _repoMenus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // obtain data
    NSArray *repoMenu = _repoMenus[indexPath.section];
    NSString *repoMenuItemTitle = repoMenu[indexPath.row];
    
    // generate cell
    UITableViewCell *repoCell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (!repoCell) {
        repoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedIdentifier];
    }
    repoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    repoCell.textLabel.text = repoMenuItemTitle;
    repoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    repoCell.imageView.image = [UIImage imageNamed:@"Home"];
    return repoCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Developer";
        case 1:
            return @"Relations";
    }
    return @"Undefined";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RepoListViewController *vc = nil;
    
    // developer
    if (indexPath.section == 0 && indexPath.row == 0) {
        vc = [[RepoListViewController alloc] initWithDataType:GithubResourceRepositories];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        vc = [[RepoListViewController alloc] initWithDataType:GithubResourceOrganizations];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        vc = [[RepoListViewController alloc] initWithDataType:GithubResourceProjects];
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        vc = [[RepoListViewController alloc] initWithDataType:GithubResourceGists];
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        vc = [[RepoListViewController alloc] initWithDataType:GithubResourceStars];
    }
    
    // relations
    if (indexPath.section == 1 && indexPath.row == 0) {
        vc = [[RepoListViewController alloc] initWithDataType:GithubResourceFollowing];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        vc = [[RepoListViewController alloc] initWithDataType:GithubResourceFollowers];
    }
    
    // navigation
    [self.navigationController pushViewController:vc animated:YES];
}

@end
