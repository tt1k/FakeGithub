// To parse this JSON:
//
//   NSError *error;
//   GistModel *model = [GistModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class GistModel;
@class GistFiles;
@class GistWindowsTerminalConfigTxt;
@class GistOwner;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

GistModel *_Nullable GistModelFromData(NSData *data, NSError **error);
GistModel *_Nullable GistModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData    *_Nullable GistModelToData(GistModel *model, NSError **error);
NSString  *_Nullable GistModelToJSON(GistModel *model, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface GistModel : NSObject
@property (nonatomic, nullable, copy)   NSString *url;
@property (nonatomic, nullable, copy)   NSString *forksURL;
@property (nonatomic, nullable, copy)   NSString *commitsURL;
@property (nonatomic, nullable, copy)   NSString *identifier;
@property (nonatomic, nullable, copy)   NSString *nodeID;
@property (nonatomic, nullable, copy)   NSString *gitPullURL;
@property (nonatomic, nullable, copy)   NSString *gitPushURL;
@property (nonatomic, nullable, copy)   NSString *htmlURL;
@property (nonatomic, nullable, strong) GistFiles *files;
@property (nonatomic, nullable, strong) NSNumber *public;
@property (nonatomic, nullable, copy)   NSString *createdAt;
@property (nonatomic, nullable, copy)   NSString *updatedAt;
@property (nonatomic, nullable, copy)   NSString *theDescription;
@property (nonatomic, nullable, strong) NSNumber *comments;
@property (nonatomic, nullable, copy)   id user;
@property (nonatomic, nullable, copy)   NSString *commentsURL;
@property (nonatomic, nullable, strong) GistOwner *owner;
@property (nonatomic, nullable, strong) NSNumber *truncated;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface GistFiles : NSObject
@property (nonatomic, nullable, strong) GistWindowsTerminalConfigTxt *windowsTerminalConfigTxt;
@end

@interface GistWindowsTerminalConfigTxt : NSObject
@property (nonatomic, nullable, copy)   NSString *filename;
@property (nonatomic, nullable, copy)   NSString *type;
@property (nonatomic, nullable, copy)   NSString *language;
@property (nonatomic, nullable, copy)   NSString *rawURL;
@property (nonatomic, nullable, strong) NSNumber *size;
@end

@interface GistOwner : NSObject
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
@end

NS_ASSUME_NONNULL_END
