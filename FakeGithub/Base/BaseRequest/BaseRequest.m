//
//  BaseRequest.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "BaseRequest.h"
#import "AFNetworking.h"
#import "BaseDomain.h"

@interface BaseRequest()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) BaseDomain *baseDomain;

@end

@implementation BaseRequest

- (instancetype)init {
    if (self = [super init]) {
        // init manager
        _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        // init baseDomain
        _baseDomain = [[BaseDomain alloc] init];
    }
    return self;
}

- (NSString *)getWithResourceType:(GithubResourceType)type andParams:(NSDictionary *)dict andBlock:(void(^)(id))block {
    NSString *url = [_baseDomain genURLWithResourceType:type];
    [_manager GET:url parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        if (block) {
            block(response);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *response) {
        NSLog(@"%@", response);
    }];
    return nil;
}

@end
