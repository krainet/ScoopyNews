//
//  RADCoreDataHelpers.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 20/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import Foundation;
@import CoreData;
@class AGTCoreDataStack;

@interface RADCoreDataUtils : NSObject

// Method with the objects matching a request
+(NSArray *) resFromFetchForEntityName:(NSString *) entityName
                                  sortedBy:(NSString *) sortingField
                                 ascending:(BOOL) ascending
                                   inStack:(AGTCoreDataStack *) stack;


+(NSArray *) resFromFetchForEntityName:(NSString *) entityName
                                  sortedBy:(NSString *) sortingField
                                 ascending:(BOOL) ascending
                             withPredicate:(NSPredicate *) predicate
                                   inStack:(AGTCoreDataStack *) stack;

@end
