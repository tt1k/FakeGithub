// To parse this JSON:
//
//   NSError *error;
//   FollowModel *FollowModel = [FollowModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class FollowModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

FollowModel *_Nullable FollowModelFromData(NSData *data, NSError **error);
FollowModel *_Nullable FollowModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData            *_Nullable FollowModelToData(FollowModel *FollowModel, NSError **error);
NSString          *_Nullable FollowModelToJSON(FollowModel *FollowModel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface FollowModel : NSObject
@property (nonatomic, nullable, copy)   NSString *login;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *nodeID;
@property (nonatomic, nullable, copy)   NSString *avatarURL;
@property (nonatomic, nullable, copy)   NSString *gravatarID;
@property (nonatomic, nullable, copy)   NSString *url;
@property (nonatomic, nullable, copy)   NSString *htmlURL;
@property (nonatomic, nullable, copy)   NSString *followersURL;
@property (nonatomic, nullable, copy)   NSString *followingURL;
@property (nonatomic, nullable, copy)   NSString *gistsURL;
@property (nonatomic, nullable, copy)   NSString *starredURL;
@property (nonatomic, nullable, copy)   NSString *subscriptionsURL;
@property (nonatomic, nullable, copy)   NSString *organizationsURL;
@property (nonatomic, nullable, copy)   NSString *reposURL;
@property (nonatomic, nullable, copy)   NSString *eventsURL;
@property (nonatomic, nullable, copy)   NSString *receivedEventsURL;
@property (nonatomic, nullable, copy)   NSString *type;
@property (nonatomic, nullable, strong) NSNumber *siteAdmin;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

NS_ASSUME_NONNULL_END
