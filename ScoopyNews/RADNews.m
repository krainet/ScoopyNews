#import "RADNews.h"
#import "RADAuthors.h"
#import "RADImages.h"
#import "RADLocation.h"


@import UIKit;
@import CoreLocation;

@interface RADNews ()<CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation RADNews

@synthesize locationManager=_locationManager;

-(BOOL) hasLocation{
    return (nil!=self.location);
}

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

#pragma mark - Localization
-(void)awakeFromInsert{
    [super awakeFromInsert];
    [self.locationManager requestWhenInUseAuthorization];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if(((status==kCLAuthorizationStatusAuthorizedWhenInUse) || (status==kCLAuthorizationStatusAuthorizedAlways) || (status==kCLAuthorizationStatusNotDetermined)) && [CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Tenemos acceso a localización");
        
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate=self;
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
    }else{
        NSLog(@"No hay acceso a localización");
    }
    
}

#pragma mark - Location delegate
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [self.locationManager stopUpdatingLocation];
    self.locationManager=nil;
    
    CLLocation *loc = [locations lastObject];
    
    self.location=[RADLocation locationWithLatitude:loc forNews:self];
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
}


@end
