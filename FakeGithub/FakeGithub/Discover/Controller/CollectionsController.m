//
//  CollectionsController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "CollectionsController.h"
#import "CollectionsModel.h"
#import "BaseDomain.h"

typedef void (^setCollectionsListBlock)(id);

@interface CollectionsController()

@property (strong, nonatomic) NSMutableArray<CollectionsModel *> *collectionsList;
@property (strong, nonatomic) void (^setCollectionsListBlock)(id);

@end

@implementation CollectionsController

static NSString *reusedIdentifier = @"collectionsCell";

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
    self.title = @"Collections";
    [self loadCollectionsList];
}

- (NSMutableArray<CollectionsModel *>*)collectionsList {
    if (!_collectionsList) {
        _collectionsList = [[NSMutableArray<CollectionsModel *> alloc] init];
    }
    return _collectionsList;
}

- (void)loadCollectionsList {
    __weak typeof(self) weakSelf = self;
    _setCollectionsListBlock = ^(id response) {
        for (NSDictionary *dict in (NSArray *)response) {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
            CollectionsModel *collectionsModel = CollectionsModelFromData(data, &error);
            [weakSelf.collectionsList addObject:collectionsModel];
        };
        [weakSelf.tableView reloadData];
    };
    [self.request getWithResourceType:GithubResourceCollections andParams:nil andBlock:_setCollectionsListBlock];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _collectionsList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // obtain data
    NSString *title = _collectionsList[indexPath.row].name;
    
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
