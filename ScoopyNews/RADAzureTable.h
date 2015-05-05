//
//  RADAzureTalbe.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 28/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import Foundation;
@class MSClient;
@class MSTable;
@class MSQuery;

@interface RADAzureTable : NSObject

@property (strong,nonatomic) MSClient *client;
@property (strong,nonatomic) MSTable *table;

@property (strong,nonatomic) NSMutableDictionary *mDictResults;
@property (strong,nonatomic) NSMutableArray *mArrayResults;
@property (strong,nonatomic) NSString *tableName;

@property (nonatomic, strong) NSMutableArray *loadedItems; // Init via [[NSMutableArray alloc] init]
@property (nonatomic) BOOL moreResults;

#pragma mark - Inits
-(id) initWithEndpoint:(NSString*) endPoint AndAppKey:(NSString*) appKey AndTable:(NSString*) tableName;


#pragma mark - Functions
-(void) insertIntoTableWithData:(NSDictionary*) dict;

-(void) readFromTable;
-(void) readWithPredicate:(NSPredicate*) predicate;
-(void) updateTableWithDictionary:(NSDictionary*)dict;
-(void) deleteWithDictionary:(NSDictionary*)dict;
-(void) readTableWithLimit:(NSInteger) limit;

@end
