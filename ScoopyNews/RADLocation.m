#import "RADLocation.h"
#import "RADNews.h"


@interface RADLocation ()



@end

@implementation RADLocation

+(instancetype) locationWithLatitude:(CLLocation*) loc
                             forNews:(RADNews*) news{

    RADLocation *location = [self insertInManagedObjectContext:news.managedObjectContext];
    
    location.latitudeValue=loc.coordinate.latitude;
    location.longitudeValue=loc.coordinate.longitude;
    return location;
}

@end
