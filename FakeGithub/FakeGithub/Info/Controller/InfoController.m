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

@interface InfoController()

@property (strong, nonatomic) NSMutableArray *infoMenus;

@end

@implementation InfoController

static NSString *reusedIdentifier = @"infoCell";

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
    // init infoMenus
    _infoMenus = [[NSMutableArray alloc] init];
    
    // user section
    NSArray *userMenu = @[@"Use Github Login"];
    [_infoMenus addObject:userMenu];
    
    // about section
    NSArray *aboutMenu = @[@"Setting", @"Developer"];
    [_infoMenus addObject:aboutMenu];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *infoMenu = _infoMenus[section];
    return infoMenu.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _infoMenus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    infoMenuItem.imageView.image = [UIImage imageNamed:@"Info"];
    return infoMenuItem;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Login";
        case 1:
            return @"Setting";
    }
    return @"Undefined";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        LoginController *loginVC  = [[LoginController alloc] init];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        SettingController *settingVC  = [[SettingController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        DevController *devVC  = [[DevController alloc] init];
        [self.navigationController presentViewController:devVC animated:YES completion:nil];
    }
}

@end
