//
//  ViewController.h
//  DeleteAddCell
//
//  Created by cavernyu on 13-11-27.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navgItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSMutableArray *teams;
@end
