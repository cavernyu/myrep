//
//  ViewController.h
//  Hello4
//
//  Created by cavernyu on 13-11-9.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;


- (IBAction)save:(id)sender;

- (IBAction)open:(id)sender;
@end
