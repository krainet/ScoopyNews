//
//  RADAzureUsers.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 29/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "Config.h"

#import "RADAzureUsers.h"
#import "RADUserDefaults.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>


@implementation RADAzureUsers

#pragma mark - Inits
-(id) initWithEndpoint:(NSString*) endPoint AndAppKey:(NSString*) appKey{
    if(self=[super init]){
        _client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZURE_ENDPOINT]
                                      applicationKey:AZURE_KEY];
        _mResponseDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}


#pragma mark - Login Facebook
-(void) facebookLoginWithController:(UIViewController*) facebookVC{
    [self.client loginWithProvider:@"Facebook" controller:facebookVC animated:YES completion:^(MSUser *user, NSError *error) {
        if(error){
            NSLog(@"Login Error");
        }else{
            NSLog(@"Login OK! %@",user);
            //NSLog(@"Current user %@",self.client.currentUser);
            //NSLog(@"Token :: %@",self.client.currentUser.mobileServiceAuthenticationToken);
            [RADUserDefaults saveValue:self.client.currentUser.mobileServiceAuthenticationToken ForKey:LOCAL_FACEBOOK_TOKEN];
            [RADUserDefaults saveValue:self.client.currentUser.userId ForKey:LOCAL_FACEBOOK_USERID];
        }
    }];
}

-(void) facebookLoginWithToken:(NSString*) token{
    
}

-(void) facebookLoginWithId:(NSString*) facebookId{
    
}


@end
