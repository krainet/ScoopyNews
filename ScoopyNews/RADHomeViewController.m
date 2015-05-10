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
#import "RNews.h"
#import "RADUserDefaults.h"
#import "RADNewsTableViewController.h"
#import "RADAuthorsTableViewController.h"

#import "RADAuthors.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>



@interface RADHomeViewController ()
@property (strong,nonatomic) AGTCoreDataStack *stack;
@property (strong,nonatomic) AGTCoreDataStack *rstack;
@property (strong,nonatomic) MSTable *table;
@end

@implementation RADHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Scoopy News Menú";
    
    self.titleLabel.text=@"Loading news...";
    [self.readButton setTitle:@"Downloading..."];
    [self.readButton setEnabled:NO];
    
    //AzureClient
    self.client = [MSClient clientWithApplicationURLString:AZURE_ENDPOINT applicationKey:AZURE_KEY];
    self.table=[self.client tableWithName:AZURE_TABLE];
    
    //Init coredata Stack
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    self.rstack = [AGTCoreDataStack coreDataStackWithModelName:@"RemoteModel"];
    
    NSPredicate *azure_predicate = [NSPredicate predicateWithFormat:@"published == %@", @"1"];
    //NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"name contains[cd] %@", query];
    //NSPredicate *predicateSSID = [NSPredicate predicateWithFormat:@"socialSecurity contains[cd] %@", query];
    //NSArray *subPredicates = [NSArray arrayWithObjects:predicateName, predicateSSID, nil];
    
    //NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
    
    
    [self.table readWithPredicate:azure_predicate
                       completion:^(NSArray *items, NSInteger totalCount, NSError *error) {
                           if(error){
                               
                           }else{
                               for (NSDictionary *dict in items) {
                                   [RNews rnewsWithDictionary:dict InContext:self.rstack.context];
                               }
                               self.activity.hidden=YES;
                               [self.activity stopAnimating];
                               self.titleLabel.text=@"Scoopy News!";
                               [self.readButton setTitle:@"Read Now!"];
                               [self.readButton setEnabled:YES];
                           }
                       }];

    
    
    
    
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
    if([self AuthUser]==YES){
        //Logado
        RADAuthorsTableViewController *nAuthorsVC = [[RADAuthorsTableViewController alloc] initWithFetchedResultsController:[self getDataForAuthor] style:UITableViewStylePlain];
        [self.navigationController pushViewController:nAuthorsVC animated:YES];
    }else{
        [self facebookLoginWithController:self];
    }
}

- (IBAction)testAction:(id)sender {
    
}



#pragma mark - CoreData
-(NSFetchedResultsController*) getData{
    
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"published == %@", @1];
    // Un fetchRequest
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RNews entityName]];
    //req.predicate=predicate;
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RNewsAttributes.datePublish ascending:NO]];
    // FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.rstack.context
                                      sectionNameKeyPath:nil
                                      cacheName:nil];

    return fc;
    
}


-(NSFetchedResultsController*) getDataForAuthor{
    // Un fetchRequest
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RADNews entityName]];
    
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

#pragma mark - Auth
-(BOOL) AuthUser{
    NSString *userFBId = [RADUserDefaults getValueForKey:LOCAL_FACEBOOK_USERID];
    if (userFBId) {
        NSString *FBToken = [RADUserDefaults getValueForKey:LOCAL_FACEBOOK_TOKEN];
        
        self.client.currentUser = [[MSUser alloc]initWithUserId:userFBId];
        self.client.currentUser.mobileServiceAuthenticationToken = FBToken;
        return YES;
    }else{
        //Go back user
        [RADUserDefaults alertWithTitle:@"Not logged" AndMessage:@"You must be logged to stay here"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    return NO;
}



#pragma mark - Unused
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
