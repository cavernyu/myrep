//
//  DetailViewController.m
//  SplitViewSample
//
//  Created by cavernyu on 13-12-19.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"blueViewController"];
    self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"yellowViewController"];
    [self.view addSubview:self.blueViewController.view];
}

-(void)updateView:(NSInteger)row
{
    if(row == 0){
        if(self.yellowViewController.view.superview){
            [self.yellowViewController.view removeFromSuperview];;
        }
        if(!self.blueViewController.view.superview){
            [self.view addSubview:self.blueViewController.view];
        }
    }else{
        if(self.blueViewController.view.superview){
            [self.blueViewController.view removeFromSuperview];;
        }
        if(!self.yellowViewController.view.superview){
            [self.view addSubview:self.yellowViewController.view];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
