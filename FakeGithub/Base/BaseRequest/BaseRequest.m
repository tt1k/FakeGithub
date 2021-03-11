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
        
        // response serializer
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        // request serializer
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // json data can be accepted only
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

        // init baseDomain
        _baseDomain = [[BaseDomain alloc] init];
    }
    return self;
}

- (void)getWithResourceType:(GithubResourceType)type andParams:(NSDictionary *)dict andBlock:(void(^)(id))block {
    NSString *url = [_baseDomain genURLWithResourceType:type];
    [_manager GET:url parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        if (block) {
            block(dict);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *response) {
        NSLog(@"%@", response);
    }];
}

- (void)postWithResourceType:(GithubResourceType)type andParams:(NSDictionary *)dict andBlock:(void(^)(id))block {
    NSString *url = [_baseDomain genURLWithResourceType:type];
    [_manager POST:url parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        if (block) {
            block(dict);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *response) {
        NSLog(@"%@", response);
    }];
}

@end
