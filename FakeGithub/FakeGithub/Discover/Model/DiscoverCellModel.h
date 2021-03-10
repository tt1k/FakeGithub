//
//  DiscoverCellModel.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

@interface DiscoverCellModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;

+ (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)desc;

@end
