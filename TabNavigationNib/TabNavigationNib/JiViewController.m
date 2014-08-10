//
//  JiViewController.m
//  TabNavigationNib
//
//  Created by cavernyu on 13-12-3.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "JiViewController.h"

@interface JiViewController ()

@end

@implementation JiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"吉林";
        self.tabBarItem.image = [UIImage imageNamed:@"Ji"];
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
