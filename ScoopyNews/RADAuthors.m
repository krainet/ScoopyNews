#import "RADAuthors.h"

@interface RADAuthors ()

// Private interface goes here.

@end

@implementation RADAuthors

+(instancetype) authorWithName:(NSString *) name
                     InContext:(NSManagedObjectContext*) context{
    
    RADAuthors *author = [RADAuthors insertInManagedObjectContext:context];
    author.author_name=name;
    author.isAppAuthor=[NSNumber numberWithInt:0];
    author.author_email=@"nohave@email.com";
    
    return author;
}



@end
