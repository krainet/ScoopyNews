#import "_RADLocation.h"
@import CoreLocation;
@class RADNews;

@interface RADLocation : _RADLocation {}

+(instancetype) locationWithLatitude:(CLLocation*) loc forNews:(RADNews*) news;


@end
