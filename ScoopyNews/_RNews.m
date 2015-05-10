// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNews.m instead.

#import "_RNews.h"

const struct RNewsAttributes RNewsAttributes = {
	.author = @"author",
	.azureId = @"azureId",
	.datePublish = @"datePublish",
	.imageURL = @"imageURL",
	.nLatitude = @"nLatitude",
	.nLongitude = @"nLongitude",
	.rating = @"rating",
	.text = @"text",
	.title = @"title",
};

@implementation RNewsID
@end

@implementation _RNews

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNews" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNews";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNews" inManagedObjectContext:moc_];
}

- (RNewsID*)objectID {
	return (RNewsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"nLatitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nLatitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"nLongitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nLongitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic author;

@dynamic azureId;

@dynamic datePublish;

@dynamic imageURL;

@dynamic nLatitude;

- (double)nLatitudeValue {
	NSNumber *result = [self nLatitude];
	return [result doubleValue];
}

- (void)setNLatitudeValue:(double)value_ {
	[self setNLatitude:@(value_)];
}

- (double)primitiveNLatitudeValue {
	NSNumber *result = [self primitiveNLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveNLatitudeValue:(double)value_ {
	[self setPrimitiveNLatitude:@(value_)];
}

@dynamic nLongitude;

- (double)nLongitudeValue {
	NSNumber *result = [self nLongitude];
	return [result doubleValue];
}

- (void)setNLongitudeValue:(double)value_ {
	[self setNLongitude:@(value_)];
}

- (double)primitiveNLongitudeValue {
	NSNumber *result = [self primitiveNLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveNLongitudeValue:(double)value_ {
	[self setPrimitiveNLongitude:@(value_)];
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

@end

