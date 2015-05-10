#import "_RADAuthors.h"

@interface RADAuthors : _RADAuthors {}

@property (nonatomic, strong) NSString *authorName;
@property (nonatomic,strong) RADAuthors *model;

+(instancetype) authorWithName:(NSString *) name
                     InContext:(NSManagedObjectContext*) context;


+(RADAuthors*) authorWithModel:(RADAuthors *) model;

@end
