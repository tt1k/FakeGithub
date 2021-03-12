#import "FollowModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface FollowModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

FollowModel *_Nullable FollowModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [FollowModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

FollowModel *_Nullable FollowModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return FollowModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable FollowModelToData(FollowModel *FollowModel, NSError **error)
{
    @try {
        id json = [FollowModel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable FollowModelToJSON(FollowModel *FollowModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = FollowModelToData(FollowModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation FollowModel
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

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return FollowModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return FollowModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[FollowModel alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = FollowModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = FollowModel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:FollowModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in FollowModel.properties) {
        id propertyName = FollowModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return FollowModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return FollowModelToJSON(self, encoding, error);
}
@end

NS_ASSUME_NONNULL_END
