//
//  BaseDomain.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "BaseDomain.h"

@implementation BaseDomain

- (NSString *)genURLWithResourceType: (GithubResourceType)type {
    switch (type) {
        case GithubResourceTrending:
            return [NSString stringWithFormat:@"%@%@", unOfficialDomain, @"/trending" ];
        case GithubResourceCollections:
            return [NSString stringWithFormat:@"%@%@", unOfficialDomain, @"/showcases" ];
        case GithubResourceAccessToken:
            return [NSString stringWithFormat:@"%@", githubOauthDomain];
        case GithubResourceStar:
            return nil;
    }
}

@end
