//
//  RepoController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/8.
//

#import <Foundation/Foundation.h>

#import "RepoController.h"

@interface RepoController()

@property (strong, nonatomic) NSMutableArray *repoList;

@end

@implementation RepoController

static NSString *reusedIdentifier = @"repoCell";

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
    // init repoList
    _repoList = [[NSMutableArray alloc] init];
    
    // mock data
    [_repoList addObjectsFromArray:@[@"111", @"222"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _repoList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // obtain data
    NSString *title = _repoList[indexPath.row];
    
    // generate cell
    UITableViewCell *repoCell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (!repoCell) {
        repoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedIdentifier];
    }
    repoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    repoCell.textLabel.text = title;
    return repoCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
