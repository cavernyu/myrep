//
//  BlueViewController.m
//  SplitViewSample
//
//  Created by cavernyu on 13-12-19.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)press:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BlueView" message:@"This is blue view" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
@end
