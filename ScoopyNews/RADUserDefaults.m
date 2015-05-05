//
//  RADUserDefaults.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 29/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import UIKit;
#import "RADUserDefaults.h"

@implementation RADUserDefaults

+(void) saveValue:(id) value ForKey:(NSString*) key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+(id) getValueForKey:(NSString*)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(void) alertWithTitle:(NSString*) title AndMessage:(NSString*) message{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:title
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert addButtonWithTitle:@"OK"];
    [alert show];
}

@end
