//
//  RADUserDefaults.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 29/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RADUserDefaults : NSObject

+(void) saveValue:(id) value ForKey:(NSString*) key;
+(id) getValueForKey:(NSString*)key;

//Alerts
+(void) alertWithTitle:(NSString*) title AndMessage:(NSString*) message;

@end
