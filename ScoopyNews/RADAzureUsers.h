//
//  RADAzureUsers.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 29/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import Foundation;
@import UIKit;

@class MSClient;
@class MSUser;

@interface RADAzureUsers : NSObject

@property (strong,nonatomic) MSClient *client;
@property (strong,nonatomic) NSMutableDictionary *mResponseDict;
@property (strong,nonatomic) MSUser *clientUser;

#pragma mark - Inits
-(id) initWithEndpoint:(NSString*) endPoint AndAppKey:(NSString*) appKey;


#pragma mark - Login Facebook
-(void) facebookLoginWithController:(UIViewController*) facebookVC;
-(void) facebookLoginWithToken:(NSString*) token;
-(void) facebookLoginWithId:(NSString*) facebookId;


@end
