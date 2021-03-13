//
//  BaseRepoView.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FeedModel.h"

@interface BaseRepoView : UIView

- (instancetype)initWithModel:(FeedModel *)model andFrame:(CGRect)frame;

@end
