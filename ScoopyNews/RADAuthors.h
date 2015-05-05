#import "_RADAuthors.h"

@interface RADAuthors : _RADAuthors {}

+(instancetype) authorWithName:(NSString *) name
                     InContext:(NSManagedObjectContext*) context;


@end
