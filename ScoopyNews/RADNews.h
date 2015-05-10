#import "_RADNews.h"

@class RADAuthors;
@class MSClient;
@class MSTable;

@interface RADNews : _RADNews {}

@property (nonatomic,readonly) BOOL hasLocation;


+(instancetype) newsWithTitle:(NSString *) title
                         Text:(NSString*) text
                       Author:(RADAuthors *) author
                    InContext:(NSManagedObjectContext*) context;

@end
