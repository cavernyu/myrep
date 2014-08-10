//
//  ViewController.m
//  StaticTableGroup
//
//  Created by cavernyu on 13-11-26.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    if([self.textPwd.text isEqualToString:@"123"] && [self.textUserName.text isEqualToString:@"tomcat"]){
        NSLog(@"登录成功");
        [self.textUserName resignFirstResponder];
        [self.textPwd resignFirstResponder];
    }
    
}
@end
