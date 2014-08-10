//
//  ViewController.h
//  IndexTable
//
//  Created by cavernyu on 13-11-26.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSDictionary *dictData;

@property (strong, nonatomic) NSArray *group;
@end
