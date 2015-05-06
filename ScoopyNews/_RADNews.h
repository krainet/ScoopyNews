// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADNews.h instead.

@import CoreData;
#import "RADScoopyNewsBaseClass.h"

extern const struct RADNewsAttributes {
	__unsafe_unretained NSString *dateAdd;
	__unsafe_unretained NSString *datePublish;
	__unsafe_unretained NSString *idCloud;
	__unsafe_unretained NSString *published;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *topublish;
} RADNewsAttributes;

extern const struct RADNewsRelationships {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *valoration;
} RADNewsRelationships;

@class RADAuthors;
@class RADImages;
@class RADLocation;
@class RADValoration;

@interface RADNewsID : NSManagedObjectID {}
@end

@interface _RADNews : RADScoopyNewsBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADNewsID* objectID;

@property (nonatomic, strong) NSDate* dateAdd;

//- (BOOL)validateDateAdd:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* datePublish;

//- (BOOL)validateDatePublish:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* idCloud;

//- (BOOL)validateIdCloud:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* published;

@property (atomic) BOOL publishedValue;
- (BOOL)publishedValue;
- (void)setPublishedValue:(BOOL)value_;

//- (BOOL)validatePublished:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* rating;

@property (atomic) int16_t ratingValue;
- (int16_t)ratingValue;
- (void)setRatingValue:(int16_t)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* topublish;

@property (atomic) BOOL topublishValue;
- (BOOL)topublishValue;
- (void)setTopublishValue:(BOOL)value_;

//- (BOOL)validateTopublish:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADAuthors *author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADImages *image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *valoration;

- (NSMutableSet*)valorationSet;

@end

@interface _RADNews (ValorationCoreDataGeneratedAccessors)
- (void)addValoration:(NSSet*)value_;
- (void)removeValoration:(NSSet*)value_;
- (void)addValorationObject:(RADValoration*)value_;
- (void)removeValorationObject:(RADValoration*)value_;

@end

@interface _RADNews (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDateAdd;
- (void)setPrimitiveDateAdd:(NSDate*)value;

- (NSDate*)primitiveDatePublish;
- (void)setPrimitiveDatePublish:(NSDate*)value;

- (NSString*)primitiveIdCloud;
- (void)setPrimitiveIdCloud:(NSString*)value;

- (NSNumber*)primitivePublished;
- (void)setPrimitivePublished:(NSNumber*)value;

- (BOOL)primitivePublishedValue;
- (void)setPrimitivePublishedValue:(BOOL)value_;

- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (int16_t)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(int16_t)value_;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSNumber*)primitiveTopublish;
- (void)setPrimitiveTopublish:(NSNumber*)value;

- (BOOL)primitiveTopublishValue;
- (void)setPrimitiveTopublishValue:(BOOL)value_;

- (RADAuthors*)primitiveAuthor;
- (void)setPrimitiveAuthor:(RADAuthors*)value;

- (RADImages*)primitiveImage;
- (void)setPrimitiveImage:(RADImages*)value;

- (RADLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(RADLocation*)value;

- (NSMutableSet*)primitiveValoration;
- (void)setPrimitiveValoration:(NSMutableSet*)value;

@end
