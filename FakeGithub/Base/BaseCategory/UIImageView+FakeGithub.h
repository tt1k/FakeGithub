//
//  UIImageView+FakeGithub.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (FakeGithub)

+ (UIImageView *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size cornerRadius:(CGFloat)radius;

@end
