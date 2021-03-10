//
//  BaseDomain.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

static NSString *officialDomain = @"https://api.github.com";
static NSString *unOfficialDomain = @"http://trending.codehub-app.com/v2";

typedef NS_ENUM(NSInteger, GithubResourceType) {
    GithubResourceTrending,
    GithubResourceCollections,
    GithubResourceStar
};

@interface BaseDomain : NSObject

- (NSString *)genURLWithResourceType: (GithubResourceType)type;

@end



