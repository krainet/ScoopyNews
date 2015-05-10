//
//  AppDelegate.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 27/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTCoreDataStack;
@class MSClient;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) AGTCoreDataStack *stack;
@property (strong,nonatomic) AGTCoreDataStack *rstack;

@property (strong,nonatomic) MSClient *client;

@end

