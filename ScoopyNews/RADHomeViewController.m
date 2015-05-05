//
//  RADHomeViewController.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 30/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "Config.h"

#import "RADHomeViewController.h"
#import "AGTCoreDataStack.h"
#import "RADNews.h"
#import "RADUserDefaults.h"
#import "RADNewsTableViewController.h"
#import "RADAuthorsTableViewController.h"

#import "RADAuthors.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface RADHomeViewController ()
@property (strong,nonatomic) AGTCoreDataStack *stack;
@end

@implementation RADHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Scoopy News Menú";
    
    //AzureClient
    self.client = [MSClient clientWithApplicationURLString:AZURE_ENDPOINT applicationKey:AZURE_KEY];
    
    //Init coredata Stack
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


#pragma mark Actions
- (IBAction)readNewsAction:(id)sender {
    RADNewsTableViewController *nVC = [[RADNewsTableViewController alloc]
                                       initWithFetchedResultsController:[self getData] style:UITableViewStylePlain];
    [self.navigationController pushViewController:nVC animated:YES];
}

- (IBAction)publishNewsAction:(id)sender {
    if(self.client.currentUser.userId){
        //Logado
        RADAuthorsTableViewController *nAuthorsVC = [[RADAuthorsTableViewController alloc] initWithFetchedResultsController:[self getDataForAuthor] style:UITableViewStylePlain];
        [self.navigationController pushViewController:nAuthorsVC animated:YES];
        
    }else{
        //No logado
        [self facebookLoginWithController:self];
    }
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Saving...");
    }];
}

- (IBAction)testAction:(id)sender {
    
    
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
        if(error){
            NSLog(@"¡Error al guardar! %@", error);
        }else {
            NSLog(@"Guardamos");
        }
    }];
    
}



#pragma mark - CoreData
-(NSFetchedResultsController*) getData{
    // Un fetchRequest
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RADNews entityName]];
//    req.sortDescriptors = @[[NSSortDescriptor
//                             sortDescriptorWithKey:RADNewsAttributes.datePublish
//                             ascending:NO
//                             selector:@selector(caseInsensitiveCompare:)]];
    req.fetchBatchSize = 20;

    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RADNewsAttributes.datePublish ascending:NO]];
    
    // FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.stack.context
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    
    return fc;
    
}

-(NSFetchedResultsController*) getDataForAuthor{
    // Un fetchRequest
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RADNews entityName]];
//    req.sortDescriptors = @[[NSSortDescriptor
//                             sortDescriptorWithKey:RADNewsAttributes.dateAdd
//                             ascending:NO
//                             selector:@selector(caseInsensitiveCompare:)]];
    
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RADNewsAttributes.dateAdd ascending:NO]];
    req.fetchBatchSize = 20;
    
    //TODO predicate
    
    // FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.stack.context
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    
    return fc;
    
}



#pragma mark - Login Facebook
-(void) facebookLoginWithController:(UIViewController*) facebookVC{
    [self.client loginWithProvider:@"Facebook" controller:facebookVC animated:YES completion:^(MSUser *user, NSError *error) {
        if(error){
            NSLog(@"Login Error");
        }else{
            NSLog(@"Login OK! %@",user);
            
            [RADUserDefaults saveValue:self.client.currentUser.mobileServiceAuthenticationToken ForKey:LOCAL_FACEBOOK_TOKEN];
            [RADUserDefaults saveValue:self.client.currentUser.userId ForKey:LOCAL_FACEBOOK_USERID];
            
            [self.client invokeAPI:@"getfacebookuserinfo"
                              body:nil
                        HTTPMethod:@"GET"
                        parameters:nil
                           headers:nil
                        completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
                            if(error){
                                NSLog(@"Error in api call... %@",error);
                            }else{
                                //NSLog(@"Api response: %@",result);
                                NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:result];
                                [RADUserDefaults saveValue:userInfo ForKey:LOCAL_FACEBOOK_USERINFO];
                            }
                        }];
            
            RADAuthorsTableViewController *nAuthorsVC = [[RADAuthorsTableViewController alloc] initWithFetchedResultsController:[self getDataForAuthor]
                                                                                                             style:UITableViewStylePlain];
            [self.navigationController pushViewController:nAuthorsVC animated:YES];
        }
    }];
}


#pragma mark - Unused
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
