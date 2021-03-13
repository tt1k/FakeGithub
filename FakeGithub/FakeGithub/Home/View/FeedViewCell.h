//
//  FeedViewCell.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/13.
//

#import <UIKit/UIKit.h>

#import "FeedModel.h"

@interface FeedViewCell : UITableViewCell

@property (strong, nonatomic) FeedModel *feedModel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier feedModel:(FeedModel *)model;

@end
