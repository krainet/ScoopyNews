//
//  RADAzureTalbe.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 28/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "Config.h"

#import "RADAzureTable.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@implementation RADAzureTable

#pragma mark - Inits
-(id) initWithEndpoint:(NSString*) endPoint AndAppKey:(NSString*) appKey AndTable:(NSString*) tableName{
    if(self=[super init]){
        _client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZURE_ENDPOINT]
                                      applicationKey:AZURE_KEY];
        
        _table=[_client tableWithName:tableName];
        _loadedItems=[[NSMutableArray alloc]init];
    }
    return self;
}



#pragma mark - Table Functions
-(void) insertIntoTableWithData:(NSDictionary*) dict{
    
    [self.table insert:dict completion:^(NSDictionary *item, NSError *error) {
        if(error){
            NSLog(@"Error insertando información en la tabla");
            self.mDictResults=[item mutableCopy];
        }else{
            NSLog(@"Datos insertados con éxito, id:%@",[item objectForKey:@"id"]);
            self.mDictResults=[item mutableCopy];
        }
    }];
}

-(void) readFromTable{
    
    [self.table readWithPredicate:nil completion:^(NSArray *items, NSInteger totalCount, NSError *error) {
        if(error){
            NSLog(@"Error al leer tabla %@",self.tableName);
            self.mArrayResults=[items mutableCopy];
        }else{
            NSLog(@"Resultados para tabla %@ : %@",self.tableName,items);
            self.mArrayResults=[items mutableCopy];
        }
    }];
}

-(void) readWithPredicate:(NSPredicate*) predicate{
    [self.table readWithPredicate:predicate
                       completion:^(NSArray *items, NSInteger totalCount, NSError *error) {
                           if(error){
                               NSLog(@"Error al leer tabla %@ ",self.tableName);
                               self.mArrayResults=[items mutableCopy];
                           }else{
                               NSLog(@"Resultados para tabla %@ : %@",self.tableName,items);
                               self.mArrayResults=[items mutableCopy];
                           }
                       }];
}


-(void) updateTableWithDictionary:(NSDictionary*)dict{
    [self.table update:dict completion:^(NSDictionary *item, NSError *error) {
        if(error){
            NSLog(@"Error al actualizar tabla %@",error);
            self.mDictResults=[item mutableCopy];
        }else{
            NSLog(@"Tabla actualizada: %@",item);
            self.mDictResults=[item mutableCopy];
        }
    }];
}

-(void) deleteWithDictionary:(NSDictionary*)dict{
    [self.table delete:dict completion:^(id itemId, NSError *error) {
        if(error){
            NSLog(@"Error al eliminar de la tabla %@: %@",self.tableName,error);
        }else{
            NSLog(@"Registro eliminado: %@",itemId);
        }
    }];
}

#pragma mark - Querys
-(void) readTableWithLimit:(NSInteger) limit{
    MSQuery *query = [self.table query];
    
    query.includeTotalCount = YES;
    query.fetchLimit = limit;
    query.fetchOffset = self.loadedItems.count;
    //query.orderBy=@"dateUpd";
    //query.selectFields=@[@"nombre",@"apellidos"];
    
    [query readWithCompletion:^(NSArray *items, NSInteger totalCount, NSError *error) {
        if(!error) {
            // Add the items to our local copy
            [self.loadedItems addObjectsFromArray:items];
            
            // Set a flag to keep track if there are any additional records we need to load
            self.moreResults = (self.loadedItems.count <= totalCount);
        }
    }];
}




@end
