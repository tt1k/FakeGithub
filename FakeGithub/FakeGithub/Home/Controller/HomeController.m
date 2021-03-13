//
//  HomeController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/8.
//

#import <Foundation/Foundation.h>

#import "HomeController.h"
#import "FeedModel.h"
#import "BaseDomain.h"
#import "FeedViewCell.h"

typedef void (^setFeedListBlock)(id);

@interface HomeController()

@property (strong, nonatomic) NSMutableArray<FeedModel *> *feedList;
@property (strong, nonatomic) void (^setFeedListBlock)(id);

@end

@implementation HomeController

static NSString *reusedIdentifier = @"feedCell";

- (instancetype)init {
    // override init method to customize TableView style setting
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _feedList = [[NSMutableArray<FeedModel *> alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetting];
}

- (void)initSetting {
    self.title = @"Feed";
    [self loadFeedList];
}

- (void)loadFeedList {
    __weak typeof(self) weakSelf = self;
    _setFeedListBlock = ^(id response) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in responseDict) {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
            FeedModel *FeedModel = FeedModelFromData(data, &error);
            [weakSelf.feedList addObject:FeedModel];
        };
        [weakSelf.tableView reloadData];
    };
    [self.request getWithResourceType:GithubResourceFeed andParams:nil andBlock:_setFeedListBlock];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _feedList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // generate cell
    FeedViewCell *feedCell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (!feedCell) {
        feedCell = [[FeedViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedIdentifier feedModel:_feedList[indexPath.section]];
    }
    return feedCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
