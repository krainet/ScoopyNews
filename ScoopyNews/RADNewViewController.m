//
//  RADNewViewController.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 30/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADNewViewController.h"
#import "RADNews.h"
#import "RADUserDefaults.h"
#import "RADImages.h"
#import "RADAuthors.h"
#import "RADLocation.h"
#import "Config.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface RADNewViewController ()

@property (strong,nonatomic) RADNews *model;
@property (strong,nonatomic) MSClient *client;
@property (strong,nonatomic) NSManagedObjectContext *context;

@end



@implementation RADNewViewController


-(id) initWithModel:(RADNews*) model AndContext:(NSManagedObjectContext *)context{
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
    if([self AuthUser]==YES){
        [self getUserInfo];
        self.newsTitle.text=self.model.title;
        self.newsText.text=self.model.text;
        self.newsImage.image=self.model.image.image;
    }
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

#pragma mark - Auth
-(BOOL) AuthUser{
    NSString *userFBId = [RADUserDefaults getValueForKey:LOCAL_FACEBOOK_USERID];
    if (userFBId) {
        NSString *FBToken = [RADUserDefaults getValueForKey:LOCAL_FACEBOOK_TOKEN];
        
        self.client.currentUser = [[MSUser alloc]initWithUserId:userFBId];
        self.client.currentUser.mobileServiceAuthenticationToken = FBToken;
        return YES;
    }else{
        //Go back user
        [RADUserDefaults alertWithTitle:@"Not logged" AndMessage:@"You must be logged to stay here"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    return NO;
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
    self.newsAuthor.text=self.model.author.author_name;
    self.latitudeLabel.text=[self.model.location.latitude stringValue];
    self.longitudeLabel.text=[self.model.location.longitude stringValue];
}

@end
