//
//  ViewController.m
//  PopoverViewSample
//
//  Created by cavernyu on 13-12-18.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#import "SelectViewController.h"

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

- (IBAction)show:(id)sender {
    SelectViewController *popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectViewController"];
    if(!self.poc){
        popoverViewController.title = @"选择你喜欢的颜色";
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:popoverViewController];
        self.poc = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    }
    [self.poc presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
@end
