// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADValoration.h instead.

@import CoreData;
#import "RADScoopyNewsBaseClass.h"

extern const struct RADValorationAttributes {
	__unsafe_unretained NSString *ratingPoints;
	__unsafe_unretained NSString *text;
} RADValorationAttributes;

extern const struct RADValorationRelationships {
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *news;
} RADValorationRelationships;

@class RADImages;
@class RADNews;

@interface RADValorationID : NSManagedObjectID {}
@end

@interface _RADValoration : RADScoopyNewsBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADValorationID* objectID;

@property (nonatomic, strong) NSNumber* ratingPoints;

@property (atomic) int16_t ratingPointsValue;
- (int16_t)ratingPointsValue;
- (void)setRatingPointsValue:(int16_t)value_;

//- (BOOL)validateRatingPoints:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADImages *image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADNews *news;

//- (BOOL)validateNews:(id*)value_ error:(NSError**)error_;

@end

@interface _RADValoration (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveRatingPoints;
- (void)setPrimitiveRatingPoints:(NSNumber*)value;

- (int16_t)primitiveRatingPointsValue;
- (void)setPrimitiveRatingPointsValue:(int16_t)value_;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (RADImages*)primitiveImage;
- (void)setPrimitiveImage:(RADImages*)value;

- (RADNews*)primitiveNews;
- (void)setPrimitiveNews:(RADNews*)value;

@end
