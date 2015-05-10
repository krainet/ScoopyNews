//
//  RADNewViewController.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 30/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADNewViewController.h"
#import "RNews.h"
#import "RADUserDefaults.h"
#import "RADImages.h"
#import "RADAuthors.h"
#import "RADLocation.h"
#import "Config.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface RADNewViewController ()

@property (strong,nonatomic) RNews *model;
@property (strong,nonatomic) MSClient *client;
@property (strong,nonatomic) NSManagedObjectContext *context;

@end



@implementation RADNewViewController


-(id) initWithModel:(RNews*) model AndContext:(NSManagedObjectContext *)context{
    if(self=[super init]){
        _model=model;
        _context=context;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [MSClient clientWithApplicationURLString:AZURE_ENDPOINT applicationKey:AZURE_KEY];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self syncViewWithModel];
}

#pragma mark - Utils
-(void) getUserInfo{
    [self.client invokeAPI:@"getfacebookuserinfo"
                      body:nil
                HTTPMethod:@"GET"
                parameters:nil
                   headers:nil
                completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
                    if(error){
                        NSLog(@"Error in api call...");
                    }else{
                        NSLog(@"Facebook Info recovered");
                    }
                }];
}



#pragma mark - Unused
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils
-(void) syncViewWithModel{
    self.newsTitle.text=self.model.title;
    self.newsText.text=self.model.text;
    self.newsAuthor.text=self.model.author;
    self.latitudeLabel.text=[self.model.nLatitude stringValue];
    self.longitudeLabel.text=[self.model.nLongitude stringValue];
    
    //Async download
    
    // Crear una cola
    dispatch_queue_t asyncimage = dispatch_queue_create("asyncimage", 0);
    
    //Poner el prefijo
    __block UIImage *image =nil;
    __block NSData *imgData=nil;
    
    //Enviar un bloque a background
    dispatch_async(asyncimage, ^{
        NSURL *url = [NSURL URLWithString:self.model.imageURL];
        
        imgData = [NSData dataWithContentsOfURL:url];
        
        //Esto vuelve a primer plano y se ejecuta
        dispatch_async(dispatch_get_main_queue(), ^{
            image = [UIImage imageWithData:imgData];
            self.newsImage.image=image;
            
        });
    });
}


@end
