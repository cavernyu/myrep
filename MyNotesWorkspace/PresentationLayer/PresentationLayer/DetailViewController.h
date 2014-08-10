//
//  DetailViewController.h
//  PresentationLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "AddViewController.h"

@interface DetailViewController : UITableViewController <UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) Note *note;
@property (strong, nonatomic) UIPopoverController *masterPopCtrl;
@property (strong, nonatomic) AddViewController *addViewController;

@end
