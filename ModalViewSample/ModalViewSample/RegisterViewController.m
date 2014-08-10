//
//  RegisterViewController.m
//  ModalViewSample
//
//  Created by cavernyu on 13-11-30.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)done:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"modal view done");
        NSDictionary *data = [NSDictionary dictionaryWithObject:self.username.text forKey:@"username"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterCompletionNotification" object:self userInfo:data];
    }];
}
@end
