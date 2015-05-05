// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADImages.h instead.

@import CoreData;
#import "RADScoopyNewsBaseClass.h"

extern const struct RADImagesAttributes {
	__unsafe_unretained NSString *imageData;
	__unsafe_unretained NSString *imageUrl;
	__unsafe_unretained NSString *title;
} RADImagesAttributes;

extern const struct RADImagesRelationships {
	__unsafe_unretained NSString *news;
	__unsafe_unretained NSString *valoration;
} RADImagesRelationships;

@class RADNews;
@class RADValoration;

@interface RADImagesID : NSManagedObjectID {}
@end

@interface _RADImages : RADScoopyNewsBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADImagesID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageUrl;

//- (BOOL)validateImageUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADNews *news;

//- (BOOL)validateNews:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADValoration *valoration;

//- (BOOL)validateValoration:(id*)value_ error:(NSError**)error_;

@end

@interface _RADImages (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (NSString*)primitiveImageUrl;
- (void)setPrimitiveImageUrl:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (RADNews*)primitiveNews;
- (void)setPrimitiveNews:(RADNews*)value;

- (RADValoration*)primitiveValoration;
- (void)setPrimitiveValoration:(RADValoration*)value;

@end
