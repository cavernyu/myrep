//
//  MainViewController.h
//  UtilitySampleStoryboard
//
//  Created by cavernyu on 13-12-28.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
