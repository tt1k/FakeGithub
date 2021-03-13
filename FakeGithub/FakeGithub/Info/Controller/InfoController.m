//
//  InfoController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/8.
//

#import <Foundation/Foundation.h>

#import "InfoController.h"
#import "DevController.h"
#import "LoginController.h"
#import "SettingController.h"
#import "BaseWebViewController.h"
#import "BaseUserDefaults.h"
#import "UserModel.h"
#import "UserInfoCell.h"

@interface InfoController() <GithubOAuthDelegate>

@property (strong, nonatomic) NSMutableArray *infoMenus;
@property (strong, nonatomic) UserModel *userModel;

@end

@implementation InfoController

static NSString *reusedIdentifier = @"infoCell";

#pragma mark UIViewController LifeCycle

- (instancetype)init {
    // override init method to customize TableView style setting
    self = [super initWithStyle:UITableViewStyleInsetGrouped];
    if (self) {
        id storedUserModel = [[BaseUserDefaults sharedDefaults] objectForKey:UserInfoModel];
        if (storedUserModel) {
            NSError *error;
            _userModel = UserModelFromData(storedUserModel, &error);
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetting];
}

# pragma mark Logic Layer

- (void)initSetting {
    // init infoMenus
    _infoMenus = [[NSMutableArray alloc] init];
    
    // user section
    NSArray *userMenu = @[@"Github Login"];
    [_infoMenus addObject:userMenu];
    
    // about section
    NSArray *aboutMenu = @[@"Setting", @"Developer"];
    [_infoMenus addObject:aboutMenu];
}

- (void)githubOAuthLogin {
    // clear cookie
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    // clear cache
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    // start oauth login
    NSString *redirect = @"https://github.com/IcedOtaku/FakeGithub";
    NSString *clientId = ClientID;
    NSString *url = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize/?client_id=%@&redirect_uri=%@&state=19991128&scope=user,public_repo", clientId, redirect];
    LoginController *aouthVC = [LoginController initWithUrl:url andTitle:@"Github OAuth Login"];
    aouthVC.delegate = self;
    [self presentViewController:aouthVC animated:YES completion:nil];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *infoMenu = _infoMenus[section];
    return infoMenu.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _infoMenus.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && _userModel) {
        return 190.0;
    }
    return self.tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // show user info card when userModal is available
    if (indexPath.section == 0 && _userModel) {
        UserInfoCell *userInfoCell = [[UserInfoCell alloc] initWithUserModel:_userModel];
        return userInfoCell;
    }
    
    // obtain title
    NSArray *infoMenu = _infoMenus[indexPath.section];
    NSString *infoMenuItemTitle = infoMenu[indexPath.row];
    
    // generate cell
    UITableViewCell *infoMenuItem = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (!infoMenuItem) {
        infoMenuItem = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedIdentifier];
    }
    infoMenuItem.selectionStyle = UITableViewCellSelectionStyleNone;
    infoMenuItem.textLabel.text = infoMenuItemTitle;
    infoMenuItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // config header icon
    if (indexPath.section == 0 && indexPath.row == 0) {
        infoMenuItem.imageView.image = [UIImage imageNamed:@"login"];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        infoMenuItem.imageView.image = [UIImage imageNamed:@"setting"];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        infoMenuItem.imageView.image = [UIImage imageNamed:@"developer"];
    }
    return infoMenuItem;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            // hide header when userModal is available
            if (section == 0 && _userModel) {
                return nil;
            }
            return @"Account";
        case 1:
            return @"Advanced";
    }
    return @"Undefined";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (!_userModel) {
            [self githubOAuthLogin];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        SettingController *settingVC  = [[SettingController alloc] init];
        [self presentViewController:settingVC animated:YES completion:nil];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        DevController *devVC  = [[DevController alloc] init];
        [self presentViewController:devVC animated:YES completion:nil];
    }
}

# pragma mark GithubOAuthDelegate

- (void)githubOAuthSuccess {
    // request for user info
    __weak typeof(self) weakSelf = self;
    [self.request getWithResourceType:GithubResourceUser andParams:nil andBlock:^(id response) {
        NSError *error;
        weakSelf.userModel = UserModelFromData(response, &error);
        [[BaseUserDefaults sharedDefaults] setObject:response forKey:UserInfoModel];
        [weakSelf.tableView reloadData];
    }];
}

- (void)githubOAuthFailed {
    
}

@end
