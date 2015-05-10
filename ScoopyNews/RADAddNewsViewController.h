//
//  RADAddNewsViewController.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 2/5/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import UIKit;
@class RADNews;

@interface RADAddNewsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *newsTitle;
@property (weak, nonatomic) IBOutlet UITextView *newsText;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomBar;

@property (weak, nonatomic) IBOutlet UITextField *locLatitude;
@property (weak, nonatomic) IBOutlet UITextField *locLongitude;

-(IBAction)takePicture:(id)sender;
-(IBAction)deleteNews:(id)sender;
-(IBAction)saveNews:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

-(id) initWithModel:(RADNews*) model AndContext:(NSManagedObjectContext*) context;

@end
