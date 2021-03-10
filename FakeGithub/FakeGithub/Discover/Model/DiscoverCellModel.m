//
//  DiscoverCellModel.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "DiscoverCellModel.h"

@implementation DiscoverCellModel

+ (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)desc {
    DiscoverCellModel *model = [[DiscoverCellModel alloc] init];
    model.title = title;
    model.desc = desc;
    return model;
}

@end
