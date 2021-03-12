// To parse this JSON:
//
//   NSError *error;
//   ProjectModel *model = [ProjectModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class ProjectModel;
@class ProjectCreator;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

ProjectModel *_Nullable ProjectModelFromData(NSData *data, NSError **error);
ProjectModel *_Nullable ProjectModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData       *_Nullable ProjectModelToData(ProjectModel *model, NSError **error);
NSString     *_Nullable ProjectModelToJSON(ProjectModel *model, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface ProjectModel : NSObject
@property (nonatomic, nullable, copy)   NSString *ownerURL;
@property (nonatomic, nullable, copy)   NSString *url;
@property (nonatomic, nullable, copy)   NSString *htmlURL;
@property (nonatomic, nullable, copy)   NSString *columnsURL;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *nodeID;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, nullable, copy)   NSString *body;
@property (nonatomic, nullable, strong) NSNumber *number;
@property (nonatomic, nullable, copy)   NSString *state;
@property (nonatomic, nullable, strong) ProjectCreator *creator;
@property (nonatomic, nullable, copy)   NSString *createdAt;
@property (nonatomic, nullable, copy)   NSString *updatedAt;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface ProjectCreator : NSObject
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
