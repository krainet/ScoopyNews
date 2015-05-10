#import "RADAuthors.h"

@interface RADAuthors ()

// Private interface goes here.

@end

@implementation RADAuthors
@synthesize model=_model;


#pragma mark -  Factory Inits
+(NSArray *) observableKeys{
    return @[RADAuthorsAttributes.author_name,RADAuthorsAttributes.author_email,RADAuthorsRelationships.news];
}

+(RADAuthors*) authorWithModel:(RADAuthors *) model{
    return model;
}

+(instancetype) authorWithName:(NSString *) name
                     InContext:(NSManagedObjectContext*) context{
    
    RADAuthors *author = [RADAuthors insertInManagedObjectContext:context];
    author.author_name=name;
    author.isAppAuthor=[NSNumber numberWithInt:0];
    author.author_email=@"nohave@email.com";
    
    return author;
}


-(NSString*) authorName{
    // Convertir la NSData en UIImage
    return self.author_name;
}

-(void) setAuthorName:(NSString*) author{
    // Convertir la NSData en UIImage
    self.author_name=author;
}



#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
}


@end
