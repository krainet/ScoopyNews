// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADLocation.h instead.

@import CoreData;
#import "RADScoopyNewsBaseClass.h"

extern const struct RADLocationAttributes {
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
} RADLocationAttributes;

extern const struct RADLocationRelationships {
	__unsafe_unretained NSString *news;
} RADLocationRelationships;

@class RADNews;

@interface RADLocationID : NSManagedObjectID {}
@end

@interface _RADLocation : RADScoopyNewsBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADLocationID* objectID;

@property (nonatomic, strong) NSNumber* latitude;

@property (atomic) float latitudeValue;
- (float)latitudeValue;
- (void)setLatitudeValue:(float)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* longitude;

@property (atomic) float longitudeValue;
- (float)longitudeValue;
- (void)setLongitudeValue:(float)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADNews *news;

//- (BOOL)validateNews:(id*)value_ error:(NSError**)error_;

@end

@interface _RADLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (float)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(float)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (float)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(float)value_;

- (RADNews*)primitiveNews;
- (void)setPrimitiveNews:(RADNews*)value;

@end
