//
//  RADAddNewsViewController.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 2/5/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADAddNewsViewController.h"
#import "RADImageViewController.h"
#import "RADNews.h"
#import "RADImages.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

#import "RADUserDefaults.h"
#import "Config.h"


@interface RADAddNewsViewController ()
@property (strong,nonatomic) RADNews *model;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) MSClient *client;
@property (strong,nonatomic) MSTable *table;


@end

@implementation RADAddNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Init
-(id) initWithModel:(RADNews*) model AndContext:(NSManagedObjectContext*) context{
    if(self=[super init]){
        _model=model;
        _client=[MSClient clientWithApplicationURLString:AZURE_ENDPOINT applicationKey:AZURE_KEY];
        _table=[_client tableWithName:@"scoopyNews"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self syncViewWithModel];
}

#pragma mark - Unused
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions
-(IBAction)takePicture:(id)sender{

    //Cloud save
    NSString *userId = [RADUserDefaults getValueForKey:LOCAL_FACEBOOK_USERID];
    NSDictionary *dict = @{@"authorId":userId,@"nowsTitle":self.newsTitle.text,@"newsText":self.newsText.text,@"pictureUrl":@""};
    [self.table insert:dict completion:^(NSDictionary *item, NSError *error) {
        if(error){
            NSLog(@"Error saving in azure:: %@",error);
        }else{
            //NSLog(@"Saved item! : %@",item);
            [RADUserDefaults alertWithTitle:@"Azure Saved" AndMessage:@"Data saved on Azure"];
            //Guardo cambios antes de irme a la foto
            self.model.title=self.newsTitle.text;
            self.model.text=self.newsText.text;
            self.model.idCloud=[item objectForKey:@"id"];
            
            
            //Vamos a tomar foto o a ver la actual
            RADImageViewController *iVC = [[RADImageViewController alloc]initWithModel:self.model AndContext:self.context];
            [self.navigationController pushViewController:iVC animated:YES];            
        }
    }];
}


-(IBAction)deleteNews:(id)sender{
    
}


-(IBAction)saveNews:(id)sender{
    self.model.title=self.newsTitle.text;
    self.model.text=self.newsText.text;
    
    NSError *error;
    [self.context save:&error];
    if(error){
        NSLog(@"Error salvando ... %@",error);
    }else{
        NSLog(@"save OK %@",error);
    }
}

#pragma mark - Utils
-(void)syncViewWithModel{
    self.newsTitle.text=self.model.title;
    self.newsText.text=self.model.text;
    self.newsImage.image=self.model.image.image;
}


@end
