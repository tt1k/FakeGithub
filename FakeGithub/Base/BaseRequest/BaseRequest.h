//
//  BaseRequest.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import "BaseDomain.h"

@interface BaseRequest : NSObject

- (NSString *)getWithResourceType:(GithubResourceType)type andParams:(NSDictionary *)dict andBlock:(void(^)(id))block;

@end
