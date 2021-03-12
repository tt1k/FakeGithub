//
//  BaseUserDefaults.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/11.
//

#import <Foundation/Foundation.h>

#import "BaseUserDefaults.h"

@implementation BaseUserDefaults

+ (id)sharedDefaults {
    static NSUserDefaults *defaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[NSUserDefaults alloc] initWithSuiteName:NSDefaultSuiteDomain];
    });
    return defaults;
}

@end
