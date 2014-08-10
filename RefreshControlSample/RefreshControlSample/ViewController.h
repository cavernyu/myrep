//
//  ViewController.h
//  RefreshControlSample
//
//  Created by cavernyu on 13-11-29.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *logs;

-(void) refreshTableView;

-(void) callBackMethod:(id) obj;
@end
