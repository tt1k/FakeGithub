#import "FeedModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface FeedModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface FeedActor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface FeedPayload (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface FeedRepo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

FeedModel *_Nullable FeedModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [FeedModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

FeedModel *_Nullable FeedModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return FeedModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable FeedModelToData(FeedModel *model, NSError **error)
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

NSString *_Nullable FeedModelToJSON(FeedModel *model, NSStringEncoding encoding, NSError **error)
{
    NSData *data = FeedModelToData(model, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation FeedModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"type": @"type",
        @"actor": @"actor",
        @"repo": @"repo",
        @"payload": @"payload",
        @"public": @"public",
        @"created_at": @"createdAt",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return FeedModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return FeedModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[FeedModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _actor = [FeedActor fromJSONDictionary:(id)_actor];
        _repo = [FeedRepo fromJSONDictionary:(id)_repo];
        _payload = [FeedPayload fromJSONDictionary:(id)_payload];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = FeedModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = FeedModel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:FeedModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in FeedModel.properties) {
        id propertyName = FeedModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"actor": NSNullify([_actor JSONDictionary]),
        @"repo": NSNullify([_repo JSONDictionary]),
        @"payload": NSNullify([_payload JSONDictionary]),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return FeedModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return FeedModelToJSON(self, encoding, error);
}
@end

@implementation FeedActor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"login": @"login",
        @"display_login": @"displayLogin",
        @"gravatar_id": @"gravatarID",
        @"url": @"url",
        @"avatar_url": @"avatarURL",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[FeedActor alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = FeedActor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = FeedActor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:FeedActor.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in FeedActor.properties) {
        id propertyName = FeedActor.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation FeedPayload
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[FeedPayload alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = FeedPayload.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = FeedPayload.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:FeedPayload.properties.allValues];
}
@end

@implementation FeedRepo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[FeedRepo alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = FeedRepo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = FeedRepo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:FeedRepo.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in FeedRepo.properties) {
        id propertyName = FeedRepo.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
