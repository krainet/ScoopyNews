#import "RADNews.h"
#import "RADAuthors.h"
#import "RADImages.h"
#import "RADLocation.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "Config.h"
#import "RADUserDefaults.h"


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
    return @[RADNewsAttributes.title,RADNewsAttributes.text,RADNewsAttributes.dateAdd,RADNewsAttributes.datePublish,RADNewsRelationships.image,RADNewsAttributes.rating, RADNewsRelationships.author,RADNewsRelationships.location,RADNewsAttributes.idCloud];
}


+(instancetype) newsWithTitle:(NSString *) title
                         Text:(NSString*) text
                       Author:(RADAuthors *) author
                    InContext:(NSManagedObjectContext*) context{
    
    MSClient *client=[MSClient clientWithApplicationURLString:AZURE_ENDPOINT applicationKey:AZURE_KEY];
    MSTable *table=[client tableWithName:AZURE_TABLE];
    
    RADNews *n = [self insertInManagedObjectContext:context];
    
    n.title=title;
    n.text=text;
    n.author=author;
    n.rating=[NSNumber numberWithInt:0];
    n.image=[RADImages insertInManagedObjectContext:context];
    n.image.image=[UIImage imageNamed:@"noimage.jpg"];
    n.published=[NSNumber numberWithBool:YES];
    n.topublish=[NSNumber numberWithBool:NO];
    n.dateAdd=[NSDate date];
    n.datePublish=[NSDate date];
    
    NSString *authorName =[[RADUserDefaults getValueForKey:LOCAL_FACEBOOK_USERINFO]objectForKey:@"name"];
    
    
    NSDictionary *dict=@{
                         @"newsTitle":n.title,
                         @"newsText":n.text,
                         @"authorId":[RADUserDefaults getValueForKey:LOCAL_FACEBOOK_USERID],
                         @"authorName":authorName,
                         @"pictureUrl":@"",
                         @"published": [NSNumber numberWithInt: [n.published integerValue]],
                         @"topublish":[NSNumber numberWithInt: [n.topublish integerValue]],
                         @"rating":[NSNumber numberWithInt: [n.rating integerValue]]
                         };
    
    [table insert:dict completion:^(NSDictionary *item, NSError *error) {
        if(error){
            NSLog(@"Error saving in azure:: %@",error);
        }else{
            [RADUserDefaults alertWithTitle:@"Azure Saved" AndMessage:@"Data saved on Azure"];
            //Guardo cambios antes de irme a la foto
            n.idCloud=[item objectForKey:@"id"];
            NSError *err;
            [n.managedObjectContext save:&err];
            if(err){
                NSLog(@"Error saving locally");
            }
        }
    }];
    
    return n;
}

#pragma mark - Localization
-(void)awakeFromInsert{
    [super awakeFromInsert];
    [self.locationManager requestWhenInUseAuthorization];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if(((status==kCLAuthorizationStatusAuthorizedWhenInUse) || (status==kCLAuthorizationStatusAuthorizedAlways) || (status==kCLAuthorizationStatusNotDetermined)) && [CLLocationManager locationServicesEnabled]){
        
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

    //NSLog(@"KeyPath: %@",keyPath);
    if(self.idCloud!=nil){
        if([keyPath isEqualToString:@"title"] || [keyPath isEqualToString:@"text"]){
            MSClient *client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZURE_ENDPOINT] applicationKey:AZURE_KEY];
            MSTable *table = [client tableWithName:AZURE_TABLE];
            NSDictionary *dict = @{@"id":self.idCloud,@"newsTitle":self.title,@"newsText":self.text};
            [table update:dict completion:^(NSDictionary *item, NSError *error) {
                if(error){
                    NSLog(@"Error updating %@",error);
                }else{
                    //NSLog(@"Updating title");
                }
            }];
        }
        if([keyPath isEqualToString:@"title"] || [keyPath isEqualToString:@"text"]){
            MSClient *client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZURE_ENDPOINT] applicationKey:AZURE_KEY];
            MSTable *table = [client tableWithName:AZURE_TABLE];
            NSDictionary *dict = @{@"id":self.idCloud,@"newsTitle":self.title,@"newsText":self.text};
            [table update:dict completion:^(NSDictionary *item, NSError *error) {
                if(error){
                    NSLog(@"Error updating %@",error);
                }else{
                    //NSLog(@"Updating news title");
                }
            }];
        }
    }

    if(self.idCloud!=nil){
        if([keyPath isEqual:@"idCloud"] && self.location.latitude!=nil){
            MSClient *client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZURE_ENDPOINT] applicationKey:AZURE_KEY];
            MSTable *table = [client tableWithName:AZURE_TABLE];
            NSDictionary *dict = @{@"id":self.idCloud,@"newsLatitude":self.location.latitude,@"newsLongitude":self.location.longitude};
            [table update:dict completion:^(NSDictionary *item, NSError *error) {
                if(error){
                    NSLog(@"Error updating %@",error);
                }else{
                    //NSLog(@"Updating location");
                }
            }];
            
        }

    }
    
    
    if([keyPath isEqualToString:@"location"] && self.idCloud!=nil){
        MSClient *client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZURE_ENDPOINT] applicationKey:AZURE_KEY];
        MSTable *table = [client tableWithName:AZURE_TABLE];
        NSDictionary *dict = @{@"id":self.idCloud,@"newsLatitude":self.location.latitude,@"newsLongitude":self.location.longitude};
        [table update:dict completion:^(NSDictionary *item, NSError *error) {
            if(error){
                NSLog(@"Error updating %@",error);
            }else{
                //NSLog(@"Updating location");
            }
        }];
    }

    
    
}


@end
