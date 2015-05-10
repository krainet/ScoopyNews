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
#import "RADLocation.h"


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
        _table=[_client tableWithName:AZURE_TABLE];
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
    
    
    NSMutableDictionary *dict = [NSMutableDictionary
                                 dictionaryWithDictionary:@{@"authorId":userId,
                                                            @"newsTitle":self.newsTitle.text,
                                                            @"newsText":self.newsText.text,
                                                            @"pictureUrl":@""
                                                            }];
    
    [dict setObject:self.model.idCloud forKey:@"id"];
    [self.table update:dict completion:^(NSDictionary *item, NSError *error) {
        if(error){
            NSLog(@"Error updating %@",error);
        }else{
            NSLog(@"Updated before takePicture");
            self.model.title=self.newsTitle.text;
            self.model.text=self.newsText.text;
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
    
    //Cloud save
    NSString *userId = [RADUserDefaults getValueForKey:LOCAL_FACEBOOK_USERID];
    
    NSMutableDictionary *dict = [NSMutableDictionary
                                 dictionaryWithDictionary:@{@"authorId":userId,
                                                            @"newsTitle":self.newsTitle.text,
                                                            @"newsText":self.newsText.text
                                                            }];
    
    [dict setObject:self.model.idCloud forKey:@"id"];
    [self.table update:dict completion:^(NSDictionary *item, NSError *error) {
        if(error){
            NSLog(@"Error updating");
            //Vamos a tomar foto o a ver la actual
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"Updated all in Azure from Button");
            //Vamos a tomar foto o a ver la actual
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];

}


#pragma mark - Utils
-(void)syncViewWithModel{
    self.newsTitle.text=self.model.title;
    self.newsText.text=self.model.text;
    self.newsImage.image=self.model.image.image;
    self.locLatitude.text=[self.model.location.latitude stringValue];
    self.locLongitude.text=[self.model.location.longitude stringValue];
}




@end
