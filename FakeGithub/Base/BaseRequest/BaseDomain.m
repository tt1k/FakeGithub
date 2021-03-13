//
//  BaseDomain.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "BaseDomain.h"
#import "BaseUserDefaults.h"
#import "UserModel.h"

@implementation BaseDomain

- (NSString *)genURLWithResourceType: (GithubResourceType)resourceType {
    id storedUserModel = [[BaseUserDefaults sharedDefaults] objectForKey:UserInfoModel];
    UserModel *userModel = nil;
    NSString *login = nil;
    if (storedUserModel) {
        NSError *error;
        userModel = UserModelFromData(storedUserModel, &error);
        login = userModel.login;
    }
    switch (resourceType) {
        case GithubResourceTrending:
            return [NSString stringWithFormat:@"%@%@", unOfficialDomain, @"/trending"];
        case GithubResourceCollections:
            return [NSString stringWithFormat:@"%@%@", unOfficialDomain, @"/showcases"];
        case GithubResourceFeed:
            return [NSString stringWithFormat:@"%@/users/%@%@", officialDomain, login, @"/received_events?per_page=100"];
        case GithubResourceAccessToken:
            return [NSString stringWithFormat:@"%@", githubOauthDomain];
        case GithubResourceFollowing:
            return [NSString stringWithFormat:@"%@/users/%@%@", officialDomain, login, @"/following?per_page=100"];
        case GithubResourceFollowers:
            return [NSString stringWithFormat:@"%@/users/%@%@", officialDomain, login, @"/followers"];
        case GithubResourceRepositories:
            return [NSString stringWithFormat:@"%@%@", officialDomain, @"/user/repos?type=all"];
        case GithubResourceOrganizations:
            return [NSString stringWithFormat:@"%@/users/%@%@", officialDomain, login, @"/orgs"];
        case GithubResourceProjects:
            return [NSString stringWithFormat:@"%@/users/%@%@", officialDomain, login, @"/projects"];
        case GithubResourceGists:
            return [NSString stringWithFormat:@"%@/users/%@%@", officialDomain, login, @"/gists"];
        case GithubResourceStars:
            return [NSString stringWithFormat:@"%@/users/%@%@", officialDomain, login, @"/starred?per_page=100"];
        case GithubResourceUser:
            return [NSString stringWithFormat:@"%@%@", officialDomain, @"/user"];
    }
}

@end
