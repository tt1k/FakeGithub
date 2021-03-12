#import "RepoModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface RepoModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface RepoLicense (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface RepoOwner (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

RepoModel *_Nullable RepoModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [RepoModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

RepoModel *_Nullable RepoModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return RepoModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable RepoModelToData(RepoModel *model, NSError **error)
{
    @try {
        id json = [model JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable RepoModelToJSON(RepoModel *model, NSStringEncoding encoding, NSError **error)
{
    NSData *data = RepoModelToData(model, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation RepoModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"node_id": @"nodeID",
        @"name": @"name",
        @"full_name": @"fullName",
        @"private": @"private",
        @"owner": @"owner",
        @"html_url": @"htmlURL",
        @"description": @"theDescription",
        @"fork": @"fork",
        @"url": @"url",
        @"forks_url": @"forksURL",
        @"keys_url": @"keysURL",
        @"collaborators_url": @"collaboratorsURL",
        @"teams_url": @"teamsURL",
        @"hooks_url": @"hooksURL",
        @"issue_events_url": @"issueEventsURL",
        @"events_url": @"eventsURL",
        @"assignees_url": @"assigneesURL",
        @"branches_url": @"branchesURL",
        @"tags_url": @"tagsURL",
        @"blobs_url": @"blobsURL",
        @"git_tags_url": @"gitTagsURL",
        @"git_refs_url": @"gitRefsURL",
        @"trees_url": @"treesURL",
        @"statuses_url": @"statusesURL",
        @"languages_url": @"languagesURL",
        @"stargazers_url": @"stargazersURL",
        @"contributors_url": @"contributorsURL",
        @"subscribers_url": @"subscribersURL",
        @"subscription_url": @"subscriptionURL",
        @"commits_url": @"commitsURL",
        @"git_commits_url": @"gitCommitsURL",
        @"comments_url": @"commentsURL",
        @"issue_comment_url": @"issueCommentURL",
        @"contents_url": @"contentsURL",
        @"compare_url": @"compareURL",
        @"merges_url": @"mergesURL",
        @"archive_url": @"archiveURL",
        @"downloads_url": @"downloadsURL",
        @"issues_url": @"issuesURL",
        @"pulls_url": @"pullsURL",
        @"milestones_url": @"milestonesURL",
        @"notifications_url": @"notificationsURL",
        @"labels_url": @"labelsURL",
        @"releases_url": @"releasesURL",
        @"deployments_url": @"deploymentsURL",
        @"created_at": @"createdAt",
        @"updated_at": @"updatedAt",
        @"pushed_at": @"pushedAt",
        @"git_url": @"gitURL",
        @"ssh_url": @"sshURL",
        @"clone_url": @"cloneURL",
        @"svn_url": @"svnURL",
        @"homepage": @"homepage",
        @"size": @"size",
        @"stargazers_count": @"stargazersCount",
        @"watchers_count": @"watchersCount",
        @"language": @"language",
        @"has_issues": @"hasIssues",
        @"has_projects": @"hasProjects",
        @"has_downloads": @"hasDownloads",
        @"has_wiki": @"hasWiki",
        @"has_pages": @"hasPages",
        @"forks_count": @"forksCount",
        @"mirror_url": @"mirrorURL",
        @"archived": @"archived",
        @"disabled": @"disabled",
        @"open_issues_count": @"openIssuesCount",
        @"license": @"license",
        @"forks": @"forks",
        @"open_issues": @"openIssues",
        @"watchers": @"watchers",
        @"default_branch": @"defaultBranch",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return RepoModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return RepoModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[RepoModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _owner = [RepoOwner fromJSONDictionary:(id)_owner];
        _license = [RepoLicense fromJSONDictionary:(id)_license];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = RepoModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = RepoModel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:RepoModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in RepoModel.properties) {
        id propertyName = RepoModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"owner": NSNullify([_owner JSONDictionary]),
        @"license": NSNullify([_license JSONDictionary]),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return RepoModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return RepoModelToJSON(self, encoding, error);
}
@end

@implementation RepoLicense
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"key": @"key",
        @"name": @"name",
        @"spdx_id": @"spdxID",
        @"url": @"url",
        @"node_id": @"nodeID",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[RepoLicense alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = RepoLicense.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = RepoLicense.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:RepoLicense.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in RepoLicense.properties) {
        id propertyName = RepoLicense.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation RepoOwner
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"login": @"login",
        @"id": @"identifier",
        @"node_id": @"nodeID",
        @"avatar_url": @"avatarURL",
        @"gravatar_id": @"gravatarID",
        @"url": @"url",
        @"html_url": @"htmlURL",
        @"followers_url": @"followersURL",
        @"following_url": @"followingURL",
        @"gists_url": @"gistsURL",
        @"starred_url": @"starredURL",
        @"subscriptions_url": @"subscriptionsURL",
        @"organizations_url": @"organizationsURL",
        @"repos_url": @"reposURL",
        @"events_url": @"eventsURL",
        @"received_events_url": @"receivedEventsURL",
        @"type": @"type",
        @"site_admin": @"siteAdmin",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[RepoOwner alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = RepoOwner.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = RepoOwner.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:RepoOwner.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in RepoOwner.properties) {
        id propertyName = RepoOwner.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
