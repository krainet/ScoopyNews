//
//  RADAzureApi.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 28/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "Config.h"

#import "RADAzureApi.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@implementation RADAzureApi

#pragma mark - Inits
-(id) initWithEndpoint:(NSString*) endPoint AndAppKey:(NSString*) appKey{
    if(self=[super init]){
        _client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZURE_ENDPOINT]
                                      applicationKey:AZURE_KEY];
        _mResponseDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}

#pragma mark - Api Call
-(void) apiQueryWithName:(NSString*) apiName
                  Method:(NSString*) method
              Parameters:(NSDictionary*) params
                 Headers:(NSDictionary*) headers{
    
    [self.client invokeAPI:apiName
                      body:nil
                HTTPMethod:method
                parameters:params
                   headers:headers
                completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
                    if(error){
                        NSLog(@"Error in api call...");
                    }else{
                        NSLog(@"Api response: %@",result);
                        self.mResponseDict=result;
                    }
    }];
}




@end
