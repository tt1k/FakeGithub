//
//  BaseDomain.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

static NSString *officialDomain = @"https://api.github.com";
static NSString *unOfficialDomain = @"http://trending.codehub-app.com/v2";
static NSString *githubOauthDomain = @"https://github.com/login/oauth/access_token";

typedef NS_ENUM(NSInteger, GithubResourceType) {
    GithubResourceTrending,
    GithubResourceCollections,
    GithubResourceAccessToken,
    GithubResourceUser
};

@interface BaseDomain : NSObject

- (NSString *)genURLWithResourceType: (GithubResourceType)type;

@end



