#import "ProjectModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface ProjectModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ProjectCreator (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

ProjectModel *_Nullable ProjectModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [ProjectModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

ProjectModel *_Nullable ProjectModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return ProjectModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable ProjectModelToData(ProjectModel *model, NSError **error)
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

NSString *_Nullable ProjectModelToJSON(ProjectModel *model, NSStringEncoding encoding, NSError **error)
{
    NSData *data = ProjectModelToData(model, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation ProjectModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"owner_url": @"ownerURL",
        @"url": @"url",
        @"html_url": @"htmlURL",
        @"columns_url": @"columnsURL",
        @"id": @"identifier",
        @"node_id": @"nodeID",
        @"name": @"name",
        @"body": @"body",
        @"number": @"number",
        @"state": @"state",
        @"creator": @"creator",
        @"created_at": @"createdAt",
        @"updated_at": @"updatedAt",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return ProjectModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return ProjectModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ProjectModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _creator = [ProjectCreator fromJSONDictionary:(id)_creator];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ProjectModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ProjectModel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ProjectModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in ProjectModel.properties) {
        id propertyName = ProjectModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"creator": NSNullify([_creator JSONDictionary]),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return ProjectModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return ProjectModelToJSON(self, encoding, error);
}
@end

@implementation ProjectCreator
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
    return dict ? [[ProjectCreator alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = ProjectCreator.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ProjectCreator.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ProjectCreator.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in ProjectCreator.properties) {
        id propertyName = ProjectCreator.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
