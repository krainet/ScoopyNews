// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNews.h instead.

@import CoreData;
#import "RADScoopyNewsBaseClass.h"

extern const struct RNewsAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *azureId;
	__unsafe_unretained NSString *datePublish;
	__unsafe_unretained NSString *imageURL;
	__unsafe_unretained NSString *nLatitude;
	__unsafe_unretained NSString *nLongitude;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *title;
} RNewsAttributes;

@interface RNewsID : NSManagedObjectID {}
@end

@interface _RNews : RADScoopyNewsBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RNewsID* objectID;

@property (nonatomic, strong) NSString* author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* azureId;

//- (BOOL)validateAzureId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* datePublish;

//- (BOOL)validateDatePublish:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageURL;

//- (BOOL)validateImageURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* nLatitude;

@property (atomic) double nLatitudeValue;
- (double)nLatitudeValue;
- (void)setNLatitudeValue:(double)value_;

//- (BOOL)validateNLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* nLongitude;

@property (atomic) double nLongitudeValue;
- (double)nLongitudeValue;
- (void)setNLongitudeValue:(double)value_;

//- (BOOL)validateNLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* rating;

@property (atomic) int16_t ratingValue;
- (int16_t)ratingValue;
- (void)setRatingValue:(int16_t)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@end

@interface _RNews (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;

- (NSString*)primitiveAzureId;
- (void)setPrimitiveAzureId:(NSString*)value;

- (NSDate*)primitiveDatePublish;
- (void)setPrimitiveDatePublish:(NSDate*)value;

- (NSString*)primitiveImageURL;
- (void)setPrimitiveImageURL:(NSString*)value;

- (NSNumber*)primitiveNLatitude;
- (void)setPrimitiveNLatitude:(NSNumber*)value;

- (double)primitiveNLatitudeValue;
- (void)setPrimitiveNLatitudeValue:(double)value_;

- (NSNumber*)primitiveNLongitude;
- (void)setPrimitiveNLongitude:(NSNumber*)value;

- (double)primitiveNLongitudeValue;
- (void)setPrimitiveNLongitudeValue:(double)value_;

- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (int16_t)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(int16_t)value_;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

@end
