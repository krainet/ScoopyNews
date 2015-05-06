#import "_RADNews.h"

@class RADAuthors;

@interface RADNews : _RADNews {}

@property (nonatomic,readonly) BOOL hasLocation;

+(instancetype) newsWithTitle:(NSString *) title
                         Text:(NSString*) text
                       Author:(RADAuthors *) author
                    InContext:(NSManagedObjectContext*) context;

@end
