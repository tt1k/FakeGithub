#import "GistModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface GistModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface GistFiles (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface GistWindowsTerminalConfigTxt (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface GistOwner (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

GistModel *_Nullable GistModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [GistModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

GistModel *_Nullable GistModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return GistModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable GistModelToData(GistModel *model, NSError **error)
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

NSString *_Nullable GistModelToJSON(GistModel *model, NSStringEncoding encoding, NSError **error)
{
    NSData *data = GistModelToData(model, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation GistModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"url": @"url",
        @"forks_url": @"forksURL",
        @"commits_url": @"commitsURL",
        @"id": @"identifier",
        @"node_id": @"nodeID",
        @"git_pull_url": @"gitPullURL",
        @"git_push_url": @"gitPushURL",
        @"html_url": @"htmlURL",
        @"files": @"files",
        @"public": @"public",
        @"created_at": @"createdAt",
        @"updated_at": @"updatedAt",
        @"description": @"theDescription",
        @"comments": @"comments",
        @"user": @"user",
        @"comments_url": @"commentsURL",
        @"owner": @"owner",
        @"truncated": @"truncated",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return GistModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return GistModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[GistModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _files = [GistFiles fromJSONDictionary:(id)_files];
        _owner = [GistOwner fromJSONDictionary:(id)_owner];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = GistModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = GistModel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:GistModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in GistModel.properties) {
        id propertyName = GistModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"files": NSNullify([_files JSONDictionary]),
        @"owner": NSNullify([_owner JSONDictionary]),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return GistModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return GistModelToJSON(self, encoding, error);
}
@end

@implementation GistFiles
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"WindowsTerminalConfig.txt": @"windowsTerminalConfigTxt",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[GistFiles alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _windowsTerminalConfigTxt = [GistWindowsTerminalConfigTxt fromJSONDictionary:(id)_windowsTerminalConfigTxt];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = GistFiles.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = GistFiles.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:GistFiles.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in GistFiles.properties) {
        id propertyName = GistFiles.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"WindowsTerminalConfig.txt": NSNullify([_windowsTerminalConfigTxt JSONDictionary]),
    }];

    return dict;
}
@end

@implementation GistWindowsTerminalConfigTxt
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"filename": @"filename",
        @"type": @"type",
        @"language": @"language",
        @"raw_url": @"rawURL",
        @"size": @"size",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[GistWindowsTerminalConfigTxt alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = GistWindowsTerminalConfigTxt.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = GistWindowsTerminalConfigTxt.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:GistWindowsTerminalConfigTxt.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in GistWindowsTerminalConfigTxt.properties) {
        id propertyName = GistWindowsTerminalConfigTxt.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation GistOwner
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
    return dict ? [[GistOwner alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = GistOwner.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = GistOwner.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:GistOwner.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in GistOwner.properties) {
        id propertyName = GistOwner.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
