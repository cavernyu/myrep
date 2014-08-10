//
//  MasterViewController.h
//  MasterDetailStoryboard
//
//  Created by cavernyu on 13-12-27.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
