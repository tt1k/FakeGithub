//
//  DiscoverController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/8.
//

#import <Foundation/Foundation.h>

#import "DiscoverController.h"
#import "DiscoverCellModel.h"
#import "DiscoverCell.h"
#import "TrendingController.h"
#import "FeedController.h"
#import "CollectionsController.h"

@interface DiscoverController()

@property (strong, nonatomic) NSMutableArray *discoverMenus;

@end

@implementation DiscoverController

static NSString *reusedIdentifier = @"dicoverCell";

- (instancetype)init {
    // override init method to customize TableView style setting
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetting];
}

- (void)initSetting {
    // init discoverMenus
    _discoverMenus = [[NSMutableArray alloc] init];
    
    // discover section
    DiscoverCellModel *trending = [DiscoverCellModel initWithTitle:@"Trending" andDescription:@"See what the GitHub community is most excited about today"];
    [_discoverMenus addObject:@[trending]];
    DiscoverCellModel *feed = [DiscoverCellModel initWithTitle:@"Feed" andDescription:@"The feed shows you events from people you follow and repositories you watch"];
    [_discoverMenus addObject:@[feed]];
    DiscoverCellModel *collections = [DiscoverCellModel initWithTitle:@"Collections" andDescription:@"Curated lists and insight into burgeoning industries, topics, and communities"];
    [_discoverMenus addObject:@[collections]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _discoverMenus.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // obtain title
    NSArray *discoverMenu = _discoverMenus[indexPath.section];
    DiscoverCellModel *discoverMenuItem = discoverMenu[indexPath.row];
    
    // generate cell
    DiscoverCell *discoverItem = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (!discoverItem) {
        discoverItem = [[DiscoverCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusedIdentifier];
    }
    discoverItem.textLabel.text = discoverMenuItem.title;
    discoverItem.textLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold];
    discoverItem.detailTextLabel.text = discoverMenuItem.desc;
    discoverItem.detailTextLabel.font = [UIFont systemFontOfSize:16.0];
    return discoverItem;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        TrendingController *trendingVC = [[TrendingController alloc] init];
        [self.navigationController pushViewController:trendingVC animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        FeedController *feedVC = [[FeedController alloc] init];
        [self.navigationController pushViewController:feedVC animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        CollectionsController *collectionsVC = [[CollectionsController alloc] init];
        [self.navigationController pushViewController:collectionsVC animated:YES];
    }
}

@end
