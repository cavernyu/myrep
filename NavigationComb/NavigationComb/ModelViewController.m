//
//  ModelViewController.m
//  NavigationComb
//
//  Created by cavernyu on 13-12-18.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ModelViewController.h"

@interface ModelViewController ()

@end

@implementation ModelViewController

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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self.textView resignFirstResponder];
    return YES;
}

- (IBAction)done:(id)sender {
}

- (IBAction)save:(id)sender {
}
@end
