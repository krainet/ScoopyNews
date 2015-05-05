//
//  RADCoreDataHelpers.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 20/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADCoreDataUtils.h"
#import "AGTCoreDataStack.h"

@implementation RADCoreDataUtils


#pragma mark - Static functions

// Method with the objects matching a request
+(NSArray *) resFromFetchForEntityName:(NSString *) entityName
                                  sortedBy:(NSString *) sortingField
                                 ascending:(BOOL) ascending
                                   inStack:(AGTCoreDataStack *) stack{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityName];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortingField
                                                          ascending:ascending
                                                           selector:@selector(caseInsensitiveCompare:)]];
    
    NSArray *results = [stack executeFetchRequest:req errorBlock:^(NSError *error) {
        NSLog(@"Error");
    }];
    
    return results;
}


+(NSArray *) resFromFetchForEntityName:(NSString *) entityName
                                  sortedBy:(NSString *) sortingField
                                 ascending:(BOOL) ascending
                             withPredicate:(NSPredicate *) predicate
                                   inStack:(AGTCoreDataStack *) stack{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityName];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortingField
                                                          ascending:ascending
                                                           selector:@selector(caseInsensitiveCompare:)]];
    req.predicate = predicate;
    
    NSArray *results = [stack executeFetchRequest:req errorBlock:^(NSError *error) {
        NSLog(@"Error");
    }];
    
    return results;
}


@end
