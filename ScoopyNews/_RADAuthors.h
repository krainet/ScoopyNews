// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADAuthors.h instead.

@import CoreData;
#import "RADScoopyNewsBaseClass.h"

extern const struct RADAuthorsAttributes {
	__unsafe_unretained NSString *author_email;
	__unsafe_unretained NSString *author_name;
	__unsafe_unretained NSString *isAppAuthor;
} RADAuthorsAttributes;

extern const struct RADAuthorsRelationships {
	__unsafe_unretained NSString *news;
} RADAuthorsRelationships;

@class RADNews;

@interface RADAuthorsID : NSManagedObjectID {}
@end

@interface _RADAuthors : RADScoopyNewsBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADAuthorsID* objectID;

@property (nonatomic, strong) NSString* author_email;

//- (BOOL)validateAuthor_email:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* author_name;

//- (BOOL)validateAuthor_name:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isAppAuthor;

@property (atomic) BOOL isAppAuthorValue;
- (BOOL)isAppAuthorValue;
- (void)setIsAppAuthorValue:(BOOL)value_;

//- (BOOL)validateIsAppAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *news;

- (NSMutableSet*)newsSet;

@end

@interface _RADAuthors (NewsCoreDataGeneratedAccessors)
- (void)addNews:(NSSet*)value_;
- (void)removeNews:(NSSet*)value_;
- (void)addNewsObject:(RADNews*)value_;
- (void)removeNewsObject:(RADNews*)value_;

@end

@interface _RADAuthors (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthor_email;
- (void)setPrimitiveAuthor_email:(NSString*)value;

- (NSString*)primitiveAuthor_name;
- (void)setPrimitiveAuthor_name:(NSString*)value;

- (NSNumber*)primitiveIsAppAuthor;
- (void)setPrimitiveIsAppAuthor:(NSNumber*)value;

- (BOOL)primitiveIsAppAuthorValue;
- (void)setPrimitiveIsAppAuthorValue:(BOOL)value_;

- (NSMutableSet*)primitiveNews;
- (void)setPrimitiveNews:(NSMutableSet*)value;

@end
