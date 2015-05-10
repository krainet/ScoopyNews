//
//  RADHomeViewController.h
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 30/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import UIKit;

@class MSClient;

@interface RADHomeViewController : UIViewController

@property (strong,nonatomic) MSClient *client;

#pragma mark - Actions
- (IBAction)readNewsAction:(id)sender;
- (IBAction)publishNewsAction:(id)sender;
- (IBAction)testAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *readButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;


@end
