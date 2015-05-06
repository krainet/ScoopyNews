// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADNews.m instead.

#import "_RADNews.h"

const struct RADNewsAttributes RADNewsAttributes = {
	.dateAdd = @"dateAdd",
	.datePublish = @"datePublish",
	.idCloud = @"idCloud",
	.published = @"published",
	.rating = @"rating",
	.text = @"text",
	.title = @"title",
	.topublish = @"topublish",
};

const struct RADNewsRelationships RADNewsRelationships = {
	.author = @"author",
	.image = @"image",
	.location = @"location",
	.valoration = @"valoration",
};

@implementation RADNewsID
@end

@implementation _RADNews

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"News" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"News";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"News" inManagedObjectContext:moc_];
}

- (RADNewsID*)objectID {
	return (RADNewsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"publishedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"published"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"topublishValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"topublish"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic dateAdd;

@dynamic datePublish;

@dynamic idCloud;

@dynamic published;

- (BOOL)publishedValue {
	NSNumber *result = [self published];
	return [result boolValue];
}

- (void)setPublishedValue:(BOOL)value_ {
	[self setPublished:@(value_)];
}

- (BOOL)primitivePublishedValue {
	NSNumber *result = [self primitivePublished];
	return [result boolValue];
}

- (void)setPrimitivePublishedValue:(BOOL)value_ {
	[self setPrimitivePublished:@(value_)];
}

@dynamic rating;

- (int16_t)ratingValue {
	NSNumber *result = [self rating];
	return [result shortValue];
}

- (void)setRatingValue:(int16_t)value_ {
	[self setRating:@(value_)];
}

- (int16_t)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result shortValue];
}

- (void)setPrimitiveRatingValue:(int16_t)value_ {
	[self setPrimitiveRating:@(value_)];
}

@dynamic text;

@dynamic title;

@dynamic topublish;

- (BOOL)topublishValue {
	NSNumber *result = [self topublish];
	return [result boolValue];
}

- (void)setTopublishValue:(BOOL)value_ {
	[self setTopublish:@(value_)];
}

- (BOOL)primitiveTopublishValue {
	NSNumber *result = [self primitiveTopublish];
	return [result boolValue];
}

- (void)setPrimitiveTopublishValue:(BOOL)value_ {
	[self setPrimitiveTopublish:@(value_)];
}

@dynamic author;

@dynamic image;

@dynamic location;

@dynamic valoration;

- (NSMutableSet*)valorationSet {
	[self willAccessValueForKey:@"valoration"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"valoration"];

	[self didAccessValueForKey:@"valoration"];
	return result;
}

@end

