// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADAuthors.m instead.

#import "_RADAuthors.h"

const struct RADAuthorsAttributes RADAuthorsAttributes = {
	.author_email = @"author_email",
	.author_name = @"author_name",
	.isAppAuthor = @"isAppAuthor",
};

const struct RADAuthorsRelationships RADAuthorsRelationships = {
	.news = @"news",
};

@implementation RADAuthorsID
@end

@implementation _RADAuthors

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Authors" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Authors";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Authors" inManagedObjectContext:moc_];
}

- (RADAuthorsID*)objectID {
	return (RADAuthorsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isAppAuthorValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isAppAuthor"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic author_email;

@dynamic author_name;

@dynamic isAppAuthor;

- (BOOL)isAppAuthorValue {
	NSNumber *result = [self isAppAuthor];
	return [result boolValue];
}

- (void)setIsAppAuthorValue:(BOOL)value_ {
	[self setIsAppAuthor:@(value_)];
}

- (BOOL)primitiveIsAppAuthorValue {
	NSNumber *result = [self primitiveIsAppAuthor];
	return [result boolValue];
}

- (void)setPrimitiveIsAppAuthorValue:(BOOL)value_ {
	[self setPrimitiveIsAppAuthor:@(value_)];
}

@dynamic news;

- (NSMutableSet*)newsSet {
	[self willAccessValueForKey:@"news"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"news"];

	[self didAccessValueForKey:@"news"];
	return result;
}

@end

