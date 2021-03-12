//
//  BaseRequest.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import "BaseDomain.h"

@interface BaseRequest : NSObject

- (void)getWithResourceType:(GithubResourceType)resourceType andParams:(NSDictionary *)dict andBlock:(void(^)(id))block;
- (void)postWithResourceType:(GithubResourceType)resourceType andParams:(NSDictionary *)dict andBlock:(void(^)(id))block;

@end
