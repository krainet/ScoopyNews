//
//  AppDelegate.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 27/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "Config.h"

#import "AppDelegate.h"

#import "AGTCoreDataStack.h"
#import "RADAzureTable.h"
#import "RADAzureApi.h"
#import "RADNews.h"
#import "RADAuthors.h"
#import "RADHomeViewController.h"

#import "RADNewsTableViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    //[self createDummyData];

    
    RADHomeViewController *hVC = [[RADHomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:hVC];
    
    //Rootview
    self.window.rootViewController=nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //[self autoSave];
    return YES;
}


#pragma mark - CoreData

-(void) getDataFromAzure{
    
}

-(void) createDummyData{
    
    // Elimino datos anteriores
    [self.stack zapAllData];
    
    
    // Creamos nuevos objetos
    RADAuthors *author1 = [RADAuthors authorWithName:@"Ramon Alberti" InContext:self.stack.context];
    RADAuthors *author2 = [RADAuthors authorWithName:@"Victor Vlazquez" InContext:self.stack.context];
    
    RADNews *noticia1 = [RADNews newsWithTitle:@"Nueva noticia 1"
                                     Text:@"Hola nueva noticia 1"
                                   Author:author1
                                InContext:self.stack.context];
    

    RADNews *noticia2 = [RADNews newsWithTitle:@"Nueva noticia 2"
                                        Text:@"Hola nueva noticia 2"
                                      Author:author2
                                   InContext:self.stack.context];

    RADNews *noticia3 = [RADNews newsWithTitle:@"Nueva noticia 3"
                                          Text:@"Hola nueva noticia 3"
                                        Author:author2
                                     InContext:self.stack.context];
    
    
    RADNews *noticia4 = [RADNews newsWithTitle:@"Nueva noticia 4"
                                          Text:@"Hola nueva noticia 4"
                                        Author:author1
                                     InContext:self.stack.context];

    RADNews *noticia5 = [RADNews newsWithTitle:@"Nueva noticia 5"
                                          Text:@"Hola nueva noticia 5"
                                        Author:author1
                                     InContext:self.stack.context];
    
    
    
    NSLog(@"Noticia1 : %@", noticia1.title);
    NSLog(@"Noticia2 : %@", noticia2.title);
    NSLog(@"Noticia1 : %@", noticia3.title);
    NSLog(@"Noticia2 : %@", noticia4.title);
    NSLog(@"Noticia1 : %@", noticia5.title);
    
    
    
    // Buscar
    NSFetchRequest *req = [NSFetchRequest
                           fetchRequestWithEntityName:[RADNews entityName]];
    
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:RADNewsAttributes.title
                             ascending:YES
                             selector:@selector(caseInsensitiveCompare:)]];
    
    
    req.fetchBatchSize = 20;
    
    //req.predicate = [NSPredicate predicateWithFormat:@"author = %@", author1];
    req.predicate=nil;
    
    NSArray *results = [self.stack
                        executeFetchRequest:req
                        errorBlock:^(NSError *error) {
                            NSLog(@"error al buscar! %@", error);
                        }];
    
    NSLog(@"Total News: %lu", (unsigned long)results.count);
    for (RADNews *n in results) {
        NSLog(@"N Tittle: %@",n.title);
    }
    // Borrar
    //[self.stack.context deleteObject:noticia2];
    
    // Guardar
    [self.stack saveWithErrorBlock:^(NSError *error) {
        //NSLog(@"¡Error al guardar! %@", error);
    }];
    
    
}


-(void) autoSave{
    if (AUTO_SAVE) {
        NSLog(@"Autoguardando");
        
        
        [self.stack saveWithErrorBlock:^(NSError *error) {
            NSLog(@"Error al autoguardar!");
            NSLog(@"%@",error);
        }];
        
        // Pongo en mi "agenda" una nueva llamada a autoSave
        [self performSelector:@selector(autoSave)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY];
        
    }
}



#pragma mark -Unused
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Utils
-(void)setUpAzure{
    _client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZURE_ENDPOINT]
                                  applicationKey:AZURE_KEY];
}

#pragma mark - Tests Azure
-(void)testTables{
    RADAzureTable *tableTest = [[RADAzureTable alloc]initWithEndpoint:AZURE_ENDPOINT
                                                            AndAppKey:AZURE_KEY
                                                             AndTable:AZURE_TEST_TABLE];
    //Insert Example
    NSDictionary *testDict = @{@"Name":@"BinLaden",@"Surname":@"Alcaeda"};
    [tableTest insertIntoTableWithData:testDict];
}

-(void)testApi{
    //Api call
    RADAzureApi *apiClient = [[RADAzureApi alloc]initWithEndpoint:AZURE_ENDPOINT AndAppKey:AZURE_KEY];
    [apiClient apiQueryWithName:AZURE_TEST_API Method:@"GET" Parameters:nil Headers:nil];
}


@end
