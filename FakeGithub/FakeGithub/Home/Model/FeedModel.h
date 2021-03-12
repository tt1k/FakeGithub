// To parse this JSON:
//
//   NSError *error;
//   FeedModel *model = [FeedModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class FeedModel;
@class FeedActor;
@class FeedPayload;
@class FeedRepo;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

FeedModel *_Nullable FeedModelFromData(NSData *data, NSError **error);
FeedModel *_Nullable FeedModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData    *_Nullable FeedModelToData(FeedModel *model, NSError **error);
NSString  *_Nullable FeedModelToJSON(FeedModel *model, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface FeedModel : NSObject
@property (nonatomic, nullable, copy)   NSString *identifier;
@property (nonatomic, nullable, copy)   NSString *type;
@property (nonatomic, nullable, strong) FeedActor *actor;
@property (nonatomic, nullable, strong) FeedRepo *repo;
@property (nonatomic, nullable, strong) FeedPayload *payload;
@property (nonatomic, nullable, strong) NSNumber *public;
@property (nonatomic, nullable, copy)   NSString *createdAt;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface FeedActor : NSObject
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *login;
@property (nonatomic, nullable, copy)   NSString *displayLogin;
@property (nonatomic, nullable, copy)   NSString *gravatarID;
@property (nonatomic, nullable, copy)   NSString *url;
@property (nonatomic, nullable, copy)   NSString *avatarURL;
@end

@interface FeedPayload : NSObject
@end

@interface FeedRepo : NSObject
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, nullable, copy)   NSString *url;
@end

NS_ASSUME_NONNULL_END
