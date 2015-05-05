// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADImages.m instead.

#import "_RADImages.h"

const struct RADImagesAttributes RADImagesAttributes = {
	.imageData = @"imageData",
	.imageUrl = @"imageUrl",
	.title = @"title",
};

const struct RADImagesRelationships RADImagesRelationships = {
	.news = @"news",
	.valoration = @"valoration",
};

@implementation RADImagesID
@end

@implementation _RADImages

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Image";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Image" inManagedObjectContext:moc_];
}

- (RADImagesID*)objectID {
	return (RADImagesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageData;

@dynamic imageUrl;

@dynamic title;

@dynamic news;

@dynamic valoration;

@end

