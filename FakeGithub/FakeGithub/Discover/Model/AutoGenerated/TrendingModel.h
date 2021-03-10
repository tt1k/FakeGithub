// To parse this JSON:
//
//   NSError *error;
//   TrendingModel *trendingModel = [TrendingModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class TrendingModel;
@class License;
@class Organization;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

TrendingModel *_Nullable TrendingModelFromData(NSData *data, NSError **error);
TrendingModel *_Nullable TrendingModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData           *_Nullable TrendingModelToData(TrendingModel *trendingModel, NSError **error);
NSString         *_Nullable TrendingModelToJSON(TrendingModel *trendingModel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface TrendingModel : NSObject
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *nodeID;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, nullable, copy)   NSString *fullName;
@property (nonatomic, nullable, strong) NSNumber *private;
@property (nonatomic, nullable, strong) Organization *owner;
@property (nonatomic, nullable, copy)   NSString *htmlURL;
@property (nonatomic, nullable, copy)   NSString *theDescription;
@property (nonatomic, nullable, strong) NSNumber *fork;
@property (nonatomic, nullable, copy)   NSString *url;
@property (nonatomic, nullable, copy)   NSString *forksURL;
@property (nonatomic, nullable, copy)   NSString *keysURL;
@property (nonatomic, nullable, copy)   NSString *collaboratorsURL;
@property (nonatomic, nullable, copy)   NSString *teamsURL;
@property (nonatomic, nullable, copy)   NSString *hooksURL;
@property (nonatomic, nullable, copy)   NSString *issueEventsURL;
@property (nonatomic, nullable, copy)   NSString *eventsURL;
@property (nonatomic, nullable, copy)   NSString *assigneesURL;
@property (nonatomic, nullable, copy)   NSString *branchesURL;
@property (nonatomic, nullable, copy)   NSString *tagsURL;
@property (nonatomic, nullable, copy)   NSString *blobsURL;
@property (nonatomic, nullable, copy)   NSString *gitTagsURL;
@property (nonatomic, nullable, copy)   NSString *gitRefsURL;
@property (nonatomic, nullable, copy)   NSString *treesURL;
@property (nonatomic, nullable, copy)   NSString *statusesURL;
@property (nonatomic, nullable, copy)   NSString *languagesURL;
@property (nonatomic, nullable, copy)   NSString *stargazersURL;
@property (nonatomic, nullable, copy)   NSString *contributorsURL;
@property (nonatomic, nullable, copy)   NSString *subscribersURL;
@property (nonatomic, nullable, copy)   NSString *subscriptionURL;
@property (nonatomic, nullable, copy)   NSString *commitsURL;
@property (nonatomic, nullable, copy)   NSString *gitCommitsURL;
@property (nonatomic, nullable, copy)   NSString *commentsURL;
@property (nonatomic, nullable, copy)   NSString *issueCommentURL;
@property (nonatomic, nullable, copy)   NSString *contentsURL;
@property (nonatomic, nullable, copy)   NSString *compareURL;
@property (nonatomic, nullable, copy)   NSString *mergesURL;
@property (nonatomic, nullable, copy)   NSString *archiveURL;
@property (nonatomic, nullable, copy)   NSString *downloadsURL;
@property (nonatomic, nullable, copy)   NSString *issuesURL;
@property (nonatomic, nullable, copy)   NSString *pullsURL;
@property (nonatomic, nullable, copy)   NSString *milestonesURL;
@property (nonatomic, nullable, copy)   NSString *notificationsURL;
@property (nonatomic, nullable, copy)   NSString *labelsURL;
@property (nonatomic, nullable, copy)   NSString *releasesURL;
@property (nonatomic, nullable, copy)   NSString *deploymentsURL;
@property (nonatomic, nullable, copy)   NSString *createdAt;
@property (nonatomic, nullable, copy)   NSString *updatedAt;
@property (nonatomic, nullable, copy)   NSString *pushedAt;
@property (nonatomic, nullable, copy)   NSString *gitURL;
@property (nonatomic, nullable, copy)   NSString *sshURL;
@property (nonatomic, nullable, copy)   NSString *cloneURL;
@property (nonatomic, nullable, copy)   NSString *svnURL;
@property (nonatomic, nullable, copy)   NSString *homepage;
@property (nonatomic, nullable, strong) NSNumber *size;
@property (nonatomic, nullable, strong) NSNumber *stargazersCount;
@property (nonatomic, nullable, strong) NSNumber *watchersCount;
@property (nonatomic, nullable, copy)   NSString *language;
@property (nonatomic, nullable, strong) NSNumber *hasIssues;
@property (nonatomic, nullable, strong) NSNumber *hasProjects;
@property (nonatomic, nullable, strong) NSNumber *hasDownloads;
@property (nonatomic, nullable, strong) NSNumber *hasWiki;
@property (nonatomic, nullable, strong) NSNumber *hasPages;
@property (nonatomic, nullable, strong) NSNumber *forksCount;
@property (nonatomic, nullable, copy)   id mirrorURL;
@property (nonatomic, nullable, strong) NSNumber *archived;
@property (nonatomic, nullable, strong) NSNumber *disabled;
@property (nonatomic, nullable, strong) NSNumber *openIssuesCount;
@property (nonatomic, nullable, strong) License *license;
@property (nonatomic, nullable, strong) NSNumber *forks;
@property (nonatomic, nullable, strong) NSNumber *openIssues;
@property (nonatomic, nullable, strong) NSNumber *watchers;
@property (nonatomic, nullable, copy)   NSString *defaultBranch;
@property (nonatomic, nullable, copy)   NSString *tempCloneToken;
@property (nonatomic, nullable, strong) Organization *organization;
@property (nonatomic, nullable, strong) NSNumber *networkCount;
@property (nonatomic, nullable, strong) NSNumber *subscribersCount;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface License : NSObject
@property (nonatomic, nullable, copy) NSString *key;
@property (nonatomic, nullable, copy) NSString *name;
@property (nonatomic, nullable, copy) NSString *spdxID;
@property (nonatomic, nullable, copy) NSString *url;
@property (nonatomic, nullable, copy) NSString *nodeID;
@end

@interface Organization : NSObject
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
