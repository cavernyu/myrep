//
//  MasterViewController.h
//  SplitViewSample
//
//  Created by cavernyu on 13-12-19.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
