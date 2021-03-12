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

- (NSMutableArray<FeedModel *>*)feedList {
    if (!_feedList) {
        _feedList = [[NSMutableArray<FeedModel *> alloc] init];
    }
    return _feedList;
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
    return _feedList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // obtain data
    NSString *title = _feedList[indexPath.row].actor.url;
    
    // generate cell
    UITableViewCell *feedCell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (!feedCell) {
        feedCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedIdentifier];
    }
    feedCell.selectionStyle = UITableViewCellSelectionStyleNone;
    feedCell.textLabel.text = title;
    return feedCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
