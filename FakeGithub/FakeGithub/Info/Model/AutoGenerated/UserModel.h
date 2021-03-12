// To parse this JSON:
//
//   NSError *error;
//   UserModel *userModel = [UserModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class UserModel;
@class UUUPlan;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

UserModel *_Nullable UserModelFromData(NSData *data, NSError **error);
UserModel *_Nullable UserModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData       *_Nullable UserModelToData(UserModel *userModel, NSError **error);
NSString     *_Nullable UserModelToJSON(UserModel *userModel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface UserModel : NSObject
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
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, nullable, copy)   NSString *company;
@property (nonatomic, nullable, copy)   NSString *blog;
@property (nonatomic, nullable, copy)   NSString *location;
@property (nonatomic, nullable, copy)   NSString *email;
@property (nonatomic, nullable, strong) NSNumber *hireable;
@property (nonatomic, nullable, copy)   NSString *bio;
@property (nonatomic, nullable, copy)   NSString *twitterUsername;
@property (nonatomic, nullable, strong) NSNumber *publicRepos;
@property (nonatomic, nullable, strong) NSNumber *publicGists;
@property (nonatomic, nullable, strong) NSNumber *followers;
@property (nonatomic, nullable, strong) NSNumber *following;
@property (nonatomic, nullable, copy)   NSString *createdAt;
@property (nonatomic, nullable, copy)   NSString *updatedAt;
@property (nonatomic, nullable, strong) NSNumber *privateGists;
@property (nonatomic, nullable, strong) NSNumber *totalPrivateRepos;
@property (nonatomic, nullable, strong) NSNumber *ownedPrivateRepos;
@property (nonatomic, nullable, strong) NSNumber *diskUsage;
@property (nonatomic, nullable, strong) NSNumber *collaborators;
@property (nonatomic, nullable, strong) NSNumber *twoFactorAuthentication;
@property (nonatomic, nullable, strong) UUUPlan *plan;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface UUUPlan : NSObject
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, nullable, strong) NSNumber *space;
@property (nonatomic, nullable, strong) NSNumber *privateRepos;
@property (nonatomic, nullable, strong) NSNumber *collaborators;
@end

NS_ASSUME_NONNULL_END
