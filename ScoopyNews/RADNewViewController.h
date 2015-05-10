//
//  RADNewViewController.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 30/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import UIKit;
@class RNews;

@interface RADNewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *newsTitle;
@property (weak, nonatomic) IBOutlet UITextView *newsText;
@property (weak, nonatomic) IBOutlet UITextField *newsAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;


#pragma mark - Init
-(id) initWithModel:(RNews*) model AndContext:(NSManagedObjectContext*) context;

@end
