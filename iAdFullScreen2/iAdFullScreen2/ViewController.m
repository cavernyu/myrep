//
//  ViewController.m
//  iAdFullScreen2
//
//  Created by cavernyu on 14-7-30.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.page1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-1.jpg"]];
    self.page1.frame = CGRectMake(0, 0, 1024, 704);
    [self.view addSubview:self.page1];
    
    self.page2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-2.jpg"]];
    self.page2.frame = CGRectMake(0, 0, 1024, 704);

    self.interstitialAd = [[ADInterstitialAd alloc] init];
    self.interstitialAd.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchView:(id)sender {
    [UIView animateWithDuration:1.0f animations:^{
        if([self.page1 superview]){
            [self.page1 removeFromSuperview];
            [self.view addSubview:self.page2];
        }else{
            [self.page2 removeFromSuperview];
            [self.view addSubview:self.page1];
        }
    } completion:^(BOOL finished) {
        if(self.interstitialAd.loaded){
//            [self.interstitialAd presentFromViewController:self];
            
            [self requestInterstitialAdPresentation];
        }
    }];
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"插页广告卸载成功");
    self.interstitialAd.delegate = nil;
    self.interstitialAd = [[ADInterstitialAd alloc] init];
    self.interstitialAd.delegate = self;
}

-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"插页广告加载成功");
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

-(BOOL)interstitialAdActionShouldBegin:(ADInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"插页广告继续执行");
    return YES;
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"插页广告结束");
    self.interstitialAd.delegate = nil;
    self.interstitialAd = [[ADInterstitialAd alloc] init];
    self.interstitialAd.delegate = self;
}

@end
