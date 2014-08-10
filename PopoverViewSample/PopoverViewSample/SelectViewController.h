//
//  SelectViewController.h
//  PopoverViewSample
//
//  Created by cavernyu on 13-12-19.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewController : UITableViewController
@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) NSIndexPath *lastIndexPath;

@end
