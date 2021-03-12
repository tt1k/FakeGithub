// To parse this JSON:
//
//   NSError *error;
//   OrgModel *model = [OrgModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class OrgModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

OrgModel *_Nullable OrgModelFromData(NSData *data, NSError **error);
OrgModel *_Nullable OrgModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData   *_Nullable OrgModelToData(OrgModel *model, NSError **error);
NSString *_Nullable OrgModelToJSON(OrgModel *model, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface OrgModel : NSObject
@property (nonatomic, nullable, copy)   NSString *login;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *nodeID;
@property (nonatomic, nullable, copy)   NSString *url;
@property (nonatomic, nullable, copy)   NSString *reposURL;
@property (nonatomic, nullable, copy)   NSString *eventsURL;
@property (nonatomic, nullable, copy)   NSString *hooksURL;
@property (nonatomic, nullable, copy)   NSString *issuesURL;
@property (nonatomic, nullable, copy)   NSString *membersURL;
@property (nonatomic, nullable, copy)   NSString *publicMembersURL;
@property (nonatomic, nullable, copy)   NSString *avatarURL;
@property (nonatomic, nullable, copy)   NSString *theDescription;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

NS_ASSUME_NONNULL_END
