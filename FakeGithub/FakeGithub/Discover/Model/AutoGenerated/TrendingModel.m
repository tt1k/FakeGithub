#import "TrendingModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface TrendingModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface License (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface Organization (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

TrendingModel *_Nullable TrendingModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [TrendingModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

TrendingModel *_Nullable TrendingModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return TrendingModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable TrendingModelToData(TrendingModel *trendingModel, NSError **error)
{
    @try {
        id json = [trendingModel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable TrendingModelToJSON(TrendingModel *trendingModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = TrendingModelToData(trendingModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation TrendingModel
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
        @"temp_clone_token": @"tempCloneToken",
        @"organization": @"organization",
        @"network_count": @"networkCount",
        @"subscribers_count": @"subscribersCount",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return TrendingModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return TrendingModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[TrendingModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _owner = [Organization fromJSONDictionary:(id)_owner];
        _license = [License fromJSONDictionary:(id)_license];
        _organization = [Organization fromJSONDictionary:(id)_organization];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = TrendingModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = TrendingModel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:TrendingModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in TrendingModel.properties) {
        id propertyName = TrendingModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"owner": NSNullify([_owner JSONDictionary]),
        @"license": NSNullify([_license JSONDictionary]),
        @"organization": NSNullify([_organization JSONDictionary]),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return TrendingModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return TrendingModelToJSON(self, encoding, error);
}
@end

@implementation License
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
    return dict ? [[License alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = License.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = License.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:License.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in License.properties) {
        id propertyName = License.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation Organization
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
    return dict ? [[Organization alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = Organization.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = Organization.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:Organization.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in Organization.properties) {
        id propertyName = Organization.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
