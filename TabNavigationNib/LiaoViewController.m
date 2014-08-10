//
//  LiaoViewController.m
//  TabNavigationNib
//
//  Created by cavernyu on 13-12-3.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "LiaoViewController.h"

@interface LiaoViewController ()

@end

@implementation LiaoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"辽林";
        self.tabBarItem.image = [UIImage imageNamed:@"Liao"];
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
