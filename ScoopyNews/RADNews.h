#import "_RADNews.h"

@class RADAuthors;

@interface RADNews : _RADNews {}

+(instancetype) newsWithTitle:(NSString *) title
                         Text:(NSString*) text
                       Author:(RADAuthors *) author
                    InContext:(NSManagedObjectContext*) context;

@end
