//
//  UIImageView+FakeGithub.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UIImageView+FakeGithub.h"

@implementation UIImageView (FakeGithub)

+ (UIImageView *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size cornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *newImageView = [[UIImageView alloc] initWithImage:newImage];
    newImageView.layer.cornerRadius = radius;
    newImageView.clipsToBounds = YES;
    return newImageView;
}

@end
