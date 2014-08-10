//
//  ViewController.m
//  Hello3
//
//  Created by cavernyu on 13-11-9.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize timer = _timer;

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

- (IBAction)testActivityIndicatorView:(id)sender {
    if([self.activityIndicator isAnimating]){
        [self.activityIndicator stopAnimating];
    }else{
        [self.activityIndicator startAnimating];
    }
    
}

- (IBAction)testProgressView:(id)sender {
    self.progressView.progress = 0.0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(download) userInfo:nil repeats:YES];
    
}

-(void) download{
    self.progressView.progress += 0.1;
    if(self.progressView.progress == 1.0){
        [self.timer invalidate];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载完毕" message:@"下载完毕" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    }
}
@end
