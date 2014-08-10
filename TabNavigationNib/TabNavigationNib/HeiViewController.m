//
//  HeiViewController.m
//  TabNavigationNib
//
//  Created by cavernyu on 13-12-3.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "HeiViewController.h"

@interface HeiViewController ()

@end

@implementation HeiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"黑龙江";
        self.tabBarItem.image = [UIImage imageNamed:@"hei"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
