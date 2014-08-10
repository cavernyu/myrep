//
//  ViewController.h
//  StaticTableGroup
//
//  Created by cavernyu on 13-11-26.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *textUserName;
@property (weak, nonatomic) IBOutlet UITextField *textPwd;
- (IBAction)login:(id)sender;

@end
