//
//  RADImageViewController.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 2/5/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import UIKit;

typedef void (^CompletionWithSasBlock) (NSString *sasUrl);

@class RADNews;

@interface RADImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;


- (IBAction)takePicture:(id)sender;
- (IBAction)saveNews:(id)sender;
- (IBAction)deletePicture:(id)sender;


-(id) initWithModel:(RADNews*) model AndContext:(NSManagedObjectContext *)context;

@end
