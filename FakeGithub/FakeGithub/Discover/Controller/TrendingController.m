//
//  TrendingController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "TrendingController.h"
#import "TrendingModel.h"
#import "BaseDomain.h"

typedef void (^setTrendingListBlock)(id);

@interface TrendingController()

@property (strong, nonatomic) NSMutableArray<TrendingModel *> *trendingList;
@property (strong, nonatomic) void (^setTrendingListBlock)(id);

@end

@implementation TrendingController

static NSString *reusedIdentifier = @"trendingCell";

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
    self.title = @"Trending";
    [self loadTrendingList];
}

- (NSMutableArray<TrendingModel *>*)trendingList {
    if (!_trendingList) {
        _trendingList = [[NSMutableArray<TrendingModel *> alloc] init];
    }
    return _trendingList;
}

- (void)loadTrendingList {
    __weak typeof(self) weakSelf = self;
    _setTrendingListBlock = ^(id response) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in responseDict) {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
            TrendingModel *trendingModel = TrendingModelFromData(data, &error);
            [weakSelf.trendingList addObject:trendingModel];
        };
        [weakSelf.tableView reloadData];
    };
    [self.request getWithResourceType:GithubResourceTrending andParams:nil andBlock:_setTrendingListBlock];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _trendingList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // obtain data
    NSString *title = _trendingList[indexPath.row].cloneURL;
    
    // generate cell
    UITableViewCell *trendingCell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (!trendingCell) {
        trendingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedIdentifier];
    }
    trendingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    trendingCell.textLabel.text = title;
    return trendingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
