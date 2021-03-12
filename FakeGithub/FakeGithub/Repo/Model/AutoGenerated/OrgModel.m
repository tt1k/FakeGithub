#import "OrgModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface OrgModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

OrgModel *_Nullable OrgModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [OrgModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

OrgModel *_Nullable OrgModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return OrgModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable OrgModelToData(OrgModel *model, NSError **error)
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

NSString *_Nullable OrgModelToJSON(OrgModel *model, NSStringEncoding encoding, NSError **error)
{
    NSData *data = OrgModelToData(model, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation OrgModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"login": @"login",
        @"id": @"identifier",
        @"node_id": @"nodeID",
        @"url": @"url",
        @"repos_url": @"reposURL",
        @"events_url": @"eventsURL",
        @"hooks_url": @"hooksURL",
        @"issues_url": @"issuesURL",
        @"members_url": @"membersURL",
        @"public_members_url": @"publicMembersURL",
        @"avatar_url": @"avatarURL",
        @"description": @"theDescription",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return OrgModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return OrgModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[OrgModel alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = OrgModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = OrgModel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:OrgModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in OrgModel.properties) {
        id propertyName = OrgModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return OrgModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return OrgModelToJSON(self, encoding, error);
}
@end

NS_ASSUME_NONNULL_END
