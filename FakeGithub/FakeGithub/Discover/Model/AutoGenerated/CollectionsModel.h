// To parse this JSON:
//
//   NSError *error;
//   CollectionsModel *collectionsModel = [CollectionsModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class CollectionsModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

CollectionsModel *_Nullable CollectionsModelFromData(NSData *data, NSError **error);
CollectionsModel *_Nullable CollectionsModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData              *_Nullable CollectionsModelToData(CollectionsModel *collectionsModel, NSError **error);
NSString            *_Nullable CollectionsModelToJSON(CollectionsModel *collectionsModel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface CollectionsModel : NSObject
@property (nonatomic, nullable, copy) NSString *theDescription;
@property (nonatomic, nullable, copy) NSString *name;
@property (nonatomic, nullable, copy) NSString *slug;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

NS_ASSUME_NONNULL_END
