//
//  ViewController.m
//  ModalViewSample
//
//  Created by cavernyu on 13-11-30.
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

- (IBAction)regonclick:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"registerViewController"];
    registerViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:registerViewController animated:YES
                     completion:^{NSLog(@"present modal view");}];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerCompletion:) name:@"RegisterCompletionNotification" object:nil];
    
}

-(void)registerCompletion:(NSNotification *)notify
{
    NSDictionary *data = [notify userInfo];
    NSString *username = [data objectForKey:@"username"];
    NSLog(@"username: %@", username);
}
@end
