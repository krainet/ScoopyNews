#import "RNews.h"

@interface RNews ()

// Private interface goes here.

@end

@implementation RNews

+(instancetype) rnewsWithDictionary:(NSDictionary*) dict InContext:(NSManagedObjectContext*) context{
    RNews *n = [RNews insertInManagedObjectContext:context];
    
    n.title=[dict objectForKey:@"newsTitle"];
    n.text=[dict objectForKey:@"newsText"];
    n.author=[dict objectForKey:@"authorName"];
    n.azureId=[dict objectForKey:@"id"];
    n.nLatitude=[dict objectForKey:@"newsLatitude"];
    n.nLongitude=[dict objectForKey:@"newsLongitude"];
    n.imageURL=[dict objectForKey:@"pictureUrl"];
    n.rating=[dict objectForKey:@"rating"];
    n.datePublish=[dict objectForKey:@"_updatedAt"];
    
    return n;
}

@end
