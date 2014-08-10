//
//  ViewController.h
//  TreeNavigationStoryboard
//
//  Created by cavernyu on 13-12-17.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *dictData;
@property (strong, nonatomic) NSArray *listData;


@end
