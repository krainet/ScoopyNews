#import "RADNews.h"
#import "RADAuthors.h"
#import "RADImages.h"

@import UIKit;

@interface RADNews ()

// Private interface goes here.

@end

@implementation RADNews

#pragma mark -  Factory Inits
+(NSArray *) observableKeys{
    return @[RADNewsAttributes.title,RADNewsAttributes.text,RADNewsAttributes.dateAdd,RADNewsAttributes.datePublish,RADNewsRelationships.image,RADNewsAttributes.rating, RADNewsRelationships.author];
}


+(instancetype) newsWithTitle:(NSString *) title
                         Text:(NSString*) text
                       Author:(RADAuthors *) author
                    InContext:(NSManagedObjectContext*) context{
    
    RADNews *n = [self insertInManagedObjectContext:context];
    
    n.title=title;
    n.text=text;
    n.author=author;
    n.rating=0;
    n.image=[RADImages insertInManagedObjectContext:context];
    n.image.image=[UIImage imageNamed:@"noimage.jpg"];
    n.published=0;
    n.topublish=0;
    n.dateAdd=[NSDate date];
    n.datePublish=[NSDate date];
    
    return n;
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
}


@end
