//
//  FeedViewCell.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/13.
//

#import <Foundation/Foundation.h>

#import "FeedViewCell.h"
#import "FeedModel.h"
#import "Masonry.h"
#import "UIImageView+FakeGithub.h"
#import "BaseRepoView.h"

@implementation FeedViewCell

static CGFloat margin = 6.0;
static CGFloat height = 100.0;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier feedModel:(FeedModel *)model {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _feedModel = model;
        [self initCellUI];
    }
    return self;
}

// overide from UIView
-(void)setFrame:(CGRect)frame {
    frame.origin.x = margin;
    frame.size.width = frame.size.width - frame.origin.x * 2;
    frame.size.height = height;
    frame.origin.y += margin;
    [super setFrame:frame];
}

// overide from UIView
-(void)layoutSubviews {
    [super layoutSubviews];
    [self setBorder];
}

// corner border logic
-(void)setBorder {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor =  UIColor.whiteColor.CGColor;
    CGRect rect = CGRectMake(margin, 0, self.frame.size.width - margin * 2, height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(8.0, 8.0)];
    layer.path = path.CGPath;
    layer.shadowColor = UIColor.lightGrayColor.CGColor;
    layer.shadowOpacity = 0.6;
    layer.shadowRadius = 2.0;
    layer.shadowOffset = CGSizeMake(1.0, 1.0);

    UIView *view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [view.layer insertSublayer:layer atIndex:0];
    self.backgroundView = view;
}

// init UI
- (void)initCellUI {
    // cell style
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIFont *mediumFont = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    UIFont *lightFont = [UIFont systemFontOfSize:14.0 weight:UIFontWeightLight];
    
    // avatar
    NSURL *avatarURL = [NSURL URLWithString:_feedModel.actor.avatarURL];
    UIImage *avatarImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:avatarURL]];
    UIImageView *avatarImageView = [UIImageView imageWithImage:avatarImage scaledToSize:CGSizeMake(40.0, 40.0) cornerRadius:20.0];
    [self addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(12.0);
        make.top.equalTo(self.mas_top).with.offset(6.0);
    }];
    
    // actor
    UILabel *actorLabel = [[UILabel alloc] init];
    actorLabel.text = _feedModel.actor.login;
    actorLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    [self addSubview:actorLabel];
    [actorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(6.0);
        make.left.equalTo(avatarImageView.mas_right).with.offset(6.0);
    }];
    
    // build different title based on event type
    if ([_feedModel.type isEqual:@"PublicEvent"]) {
        // made
        UILabel *madeLabel = [[UILabel alloc] init];
        madeLabel.text = @"made";
        madeLabel.font = lightFont;
        [self addSubview:madeLabel];
        [madeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(actorLabel.mas_right).with.offset(4.0);
        }];
        
        // repo
        UILabel *repoLabel = [[UILabel alloc] init];
        repoLabel.text = _feedModel.repo.name;
        repoLabel.font = mediumFont;
        [self addSubview:repoLabel];
        [repoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(madeLabel.mas_right).with.offset(4.0);
        }];
        
        // public
        UILabel *publicLabel = [[UILabel alloc] init];
        publicLabel.text = @"public";
        publicLabel.font = lightFont;
        [self addSubview:publicLabel];
        [publicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(repoLabel.mas_right).with.offset(4.0);
        }];
    }
    
    if ([_feedModel.type isEqual:@"ForkEvent"]) {
        // forked
        UILabel *forkedLabel = [[UILabel alloc] init];
        forkedLabel.text = @"forked";
        forkedLabel.font = lightFont;
        [self addSubview:forkedLabel];
        [forkedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(actorLabel.mas_right).with.offset(4.0);
        }];
        
        // my repo
        UILabel *myRepoLabel = [[UILabel alloc] init];
        myRepoLabel.text = _feedModel.payload.forkee.fullName;
        myRepoLabel.font = mediumFont;
        [self addSubview:myRepoLabel];
        [myRepoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(forkedLabel.mas_right).with.offset(4.0);
        }];
        
        // from
        UILabel *fromLabel = [[UILabel alloc] init];
        fromLabel.text = @"from";
        fromLabel.font = lightFont;
        [self addSubview:fromLabel];
        [fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(myRepoLabel.mas_right).with.offset(4.0);
        }];
        
        // being forked repo
        UILabel *forkedRepoLabel = [[UILabel alloc] init];
        forkedRepoLabel.text = _feedModel.repo.name;
        forkedRepoLabel.font = mediumFont;
        [self addSubview:forkedRepoLabel];
        [forkedRepoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(fromLabel.mas_right).with.offset(4.0);
        }];
        
        // base repo view
        BaseRepoView *baseRepoView = [[BaseRepoView alloc] initWithModel:_feedModel andFrame:CGRectMake(0.0, 0.0, 300.0, 100.0)];
        baseRepoView.backgroundColor = UIColor.orangeColor;
        [self addSubview:baseRepoView];
        [baseRepoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatarImageView.mas_right).with.offset(6.0);
            make.top.equalTo(actorLabel.mas_bottom).with.offset(0.0);
        }];
    }
    
    if ([_feedModel.type isEqual:@"WatchEvent"]) {
        // IcedOtaku starred 521xueweihan/git-tips
        // starred
        UILabel *starredLabel = [[UILabel alloc] init];
        starredLabel.text = @"starred";
        starredLabel.font = lightFont;
        [self addSubview:starredLabel];
        [starredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(actorLabel.mas_right).with.offset(4.0);
        }];
        
        // repo
        UILabel *repoLabel = [[UILabel alloc] init];
        repoLabel.text = _feedModel.repo.name;
        repoLabel.font = mediumFont;
        [self addSubview:repoLabel];
        [repoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(6.0);
            make.left.equalTo(starredLabel.mas_right).with.offset(4.0);
        }];
    }
}

@end
