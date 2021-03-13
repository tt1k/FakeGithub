//
//  UserInfoCell.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/12.
//

#import <Foundation/Foundation.h>

#import "UserInfoCell.h"
#import "Masonry.h"
#import "UIImageView+FakeGithub.h"

@interface UserInfoCell()

@property (strong, nonatomic) UserModel *userModel;

@end

@implementation UserInfoCell

static CGFloat height = 190.0;

- (instancetype)initWithUserModel:(UserModel *)model {
    if (self = [super init]) {
        _userModel = model;
        [self initCellUI];
    }
    return self;
}

// overide from UIView
-(void)setFrame:(CGRect)frame {
    frame.size.height = height;
    [super setFrame:frame];
}

// init UI
- (void)initCellUI {
    // cell style
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // avatar
    NSURL *avatarURL = [NSURL URLWithString:_userModel.avatarURL];
    UIImage *avatarImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:avatarURL]];
    UIImageView *avatarImageView = [UIImageView imageWithImage:avatarImage scaledToSize:CGSizeMake(60.0, 60.0) cornerRadius:30.0];
    [self addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(16.0);
        make.top.equalTo(self.mas_top).with.offset(16.0);
    }];
    
    // name
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = _userModel.name;
    nameLabel.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarImageView.mas_right).with.offset(20.0);
        make.top.equalTo(avatarImageView).with.offset(8.0);
    }];
    
    // login
    UILabel *loginLabel = [[UILabel alloc] init];
    loginLabel.text = _userModel.login;
    loginLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
    loginLabel.textColor = UIColor.grayColor;
    [self addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarImageView.mas_right).with.offset(20.0);
        make.bottom.equalTo(avatarImageView.mas_bottom).with.offset(-8.0);
    }];
    
    // bio
    UILabel *bioLabel = [[UILabel alloc] init];
    if (!_userModel.bio) {
        _userModel.bio = @"This developer has not wrote description";
    }
    bioLabel.text = _userModel.bio;
    bioLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightLight];
    [self addSubview:bioLabel];
    [bioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarImageView.mas_left);
        make.top.equalTo(avatarImageView.mas_bottom).with.offset(8.0);
    }];
    
    // company icon
    UIImageView *companyIconView = [UIImageView imageWithImage:[UIImage imageNamed:@"company"] scaledToSize:CGSizeMake(20.0, 20.0) cornerRadius:0.0];
    [self addSubview:companyIconView];
    [companyIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarImageView.mas_left);
        make.top.equalTo(bioLabel.mas_bottom).with.offset(6.0);
    }];
    
    // company
    UILabel *companyLabel = [[UILabel alloc] init];
    if (!_userModel.company) {
        _userModel.company = @"Empty";
    }
    companyLabel.text = _userModel.company;
    companyLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightLight];
    [self addSubview:companyLabel];
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(companyIconView.mas_right).with.offset(4.0);
        make.centerY.equalTo(companyIconView.mas_centerY);
    }];
    
    // location icon
    UIImageView *locationIconView = [UIImageView imageWithImage:[UIImage imageNamed:@"location"] scaledToSize:CGSizeMake(20.0, 20.0) cornerRadius:0.0];
    [self addSubview:locationIconView];
    [locationIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(companyLabel.mas_right).with.offset(6.0);
        make.top.equalTo(bioLabel.mas_bottom).with.offset(6.0);
    }];
    
    // location
    UILabel *locationLabel = [[UILabel alloc] init];
    if (!_userModel.location) {
        _userModel.location = @"Empty";
    }
    locationLabel.text = _userModel.location;
    locationLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightLight];
    [self addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIconView.mas_right).with.offset(4.0);
        make.centerY.equalTo(locationIconView.mas_centerY);
    }];
    
    // blog icon
    UIImageView *blogIconView = [UIImageView imageWithImage:[UIImage imageNamed:@"link"] scaledToSize:CGSizeMake(20.0, 20.0) cornerRadius:0.0];
    [self addSubview:blogIconView];
    [blogIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarImageView.mas_left);
        make.top.equalTo(companyIconView.mas_bottom).with.offset(6.0);
    }];
    
    // blog
    UILabel *blogLabel = [[UILabel alloc] init];
    if ([_userModel.blog isEqual:@""]) {
        _userModel.blog = @"Empty";
    }
    blogLabel.text = _userModel.blog;
    blogLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightLight];
    [self addSubview:blogLabel];
    [blogLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(blogIconView.mas_right).with.offset(4.0);
        make.centerY.equalTo(blogIconView.mas_centerY);
    }];
    
    // follow icon
    UIImageView *followIconView = [UIImageView imageWithImage:[UIImage imageNamed:@"people"] scaledToSize:CGSizeMake(20.0, 20.0) cornerRadius:0.0];
    [self addSubview:followIconView];
    [followIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarImageView.mas_left);
        make.top.equalTo(blogLabel.mas_bottom).with.offset(6.0);
    }];
    
    // followers
    UILabel *followersLabel = [[UILabel alloc] init];
    followersLabel.text = [NSString stringWithFormat:@"%@ followers", _userModel.followers];
    followersLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightLight];
    [self addSubview:followersLabel];
    [followersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(followIconView.mas_right).with.offset(4.0);
        make.centerY.equalTo(followIconView.mas_centerY);
    }];
    
    // following
    UILabel *followingLabel = [[UILabel alloc] init];
    followingLabel.text = [NSString stringWithFormat:@"· %@ following", _userModel.following];;
    followingLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightLight];
    [self addSubview:followingLabel];
    [followingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(followersLabel.mas_right).with.offset(4.0);
        make.centerY.equalTo(followIconView.mas_centerY);
    }];
}

@end
