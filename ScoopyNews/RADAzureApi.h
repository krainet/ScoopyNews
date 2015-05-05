//
//  RADAzureApi.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 28/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import Foundation;

@class MSClient;


@interface RADAzureApi : NSObject

@property (strong,nonatomic) MSClient *client;
@property (strong,nonatomic) NSHTTPURLResponse *response;
@property (strong,nonatomic) NSMutableDictionary *mResponseDict;

#pragma mark - Inits
-(id) initWithEndpoint:(NSString*) endPoint AndAppKey:(NSString*) appKey;

#pragma mark - Functions
-(void) apiQueryWithName:(NSString*) apiName
                  Method:(NSString*) method
              Parameters:(NSDictionary*) params
                 Headers:(NSDictionary*) headers;

@end
