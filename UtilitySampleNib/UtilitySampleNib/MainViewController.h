//
//  MainViewController.h
//  UtilitySampleNib
//
//  Created by cavernyu on 13-12-28.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;


- (IBAction)showInfo:(id)sender;

@end
