// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADValoration.m instead.

#import "_RADValoration.h"

const struct RADValorationAttributes RADValorationAttributes = {
	.ratingPoints = @"ratingPoints",
	.text = @"text",
};

const struct RADValorationRelationships RADValorationRelationships = {
	.image = @"image",
	.news = @"news",
};

@implementation RADValorationID
@end

@implementation _RADValoration

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Valoration" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Valoration";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Valoration" inManagedObjectContext:moc_];
}

- (RADValorationID*)objectID {
	return (RADValorationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"ratingPointsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ratingPoints"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic ratingPoints;

- (int16_t)ratingPointsValue {
	NSNumber *result = [self ratingPoints];
	return [result shortValue];
}

- (void)setRatingPointsValue:(int16_t)value_ {
	[self setRatingPoints:@(value_)];
}

- (int16_t)primitiveRatingPointsValue {
	NSNumber *result = [self primitiveRatingPoints];
	return [result shortValue];
}

- (void)setPrimitiveRatingPointsValue:(int16_t)value_ {
	[self setPrimitiveRatingPoints:@(value_)];
}

@dynamic text;

@dynamic image;

@dynamic news;

@end

