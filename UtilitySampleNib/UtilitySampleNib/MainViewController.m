//
//  MainViewController.m
//  UtilitySampleNib
//
//  Created by cavernyu on 13-12-28.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }


    return self;
}

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

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (IBAction)showInfo:(id)sender {
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        FlipsideViewController *flipsideViewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
        flipsideViewController.delegate = self;
        flipsideViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:flipsideViewController animated:YES completion:nil];
    }else{
        if(!self.flipsidePopoverController){
            FlipsideViewController *flipsideViewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
            flipsideViewController.delegate = self;
            self.flipsidePopoverController = [[UIPopoverController alloc] initWithContentViewController:flipsideViewController];
        }
        if([self.flipsidePopoverController isPopoverVisible]){
            [self.flipsidePopoverController dismissPopoverAnimated:YES];
        }else{
            [self.flipsidePopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}
@end
