//
//  ViewController.m
//  Hello7
//
//  Created by cavernyu on 13-11-9.
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

- (IBAction)onclick:(id)sender {
    NSDate *date = self.datePicker.date;
    NSLog(@"the date picker:%@", [date descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSLog(@"the date formate is:%@", [dateFormatter stringFromDate:date]);
    self.label.text = [dateFormatter stringFromDate:date];
    
}
@end
