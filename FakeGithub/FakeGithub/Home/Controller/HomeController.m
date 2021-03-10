//
//  HomeController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/8.
//

#import <Foundation/Foundation.h>

#import "HomeController.h"

@interface HomeController()

@property (strong, nonatomic) NSMutableArray *exploreList;

@end

@implementation HomeController

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
    // init exploreList
    _exploreList = [[NSMutableArray alloc] init];
    
    // mock data
    [_exploreList addObjectsFromArray:@[@"111", @"222"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _exploreList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // obtain data
    NSString *title = _exploreList[indexPath.row];
    
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
