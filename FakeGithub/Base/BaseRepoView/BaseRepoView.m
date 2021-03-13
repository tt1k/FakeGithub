//
//  BaseRepoView.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/13.
//

#import <Foundation/Foundation.h>

#import "BaseRepoView.h"
#import "FeedModel.h"
#import "Masonry.h"

@interface BaseRepoView()

@property (strong, nonatomic) FeedModel *model;

@end

@implementation BaseRepoView

- (instancetype)initWithModel:(FeedModel *)model andFrame:(CGRect)frame {
    if (self = [super init]) {
        _model = model;
        [self initBaseRepoView];
    }
    return self;
}

- (void)initBaseRepoView {
    UIFont *mediumFont = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    UIFont *lightFont = [UIFont systemFontOfSize:14.0 weight:UIFontWeightLight];
    
    // repo
    UILabel *repoLabel = [[UILabel alloc] init];
    repoLabel.text = _model.repo.name;
    repoLabel.font = mediumFont;
    [self addSubview:repoLabel];
    [repoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(6.0);
        make.left.equalTo(self.mas_right);
    }];
    
    // description
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.text = _model.payload.forkee.theDescription;
    descLabel.font = lightFont;
    [self addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(repoLabel.mas_bottom).with.offset(2.0);
        make.left.equalTo(self.mas_right);
    }];
}

@end
