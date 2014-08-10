//
//  ViewController.m
//  iAdFullScreen1
//
//  Created by cavernyu on 14-7-29.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH 1024
#define SCREEN_HEIGHT 768

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.interstitialAd = [[ADInterstitialAd alloc] init];
    self.interstitialAd.delegate = self;
    
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointZero;
    
    self.pageList = [[NSMutableArray alloc] init];
    [self.pageList addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-1.jpg"]]];
    [self.pageList addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-2.jpg"]]];
    [self.pageList addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple-3.jpg"]]];
    
    [self reloadPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadPage
{
    int frameHeight = self.scrollView.frame.size.height;
    self.pageCtrl.numberOfPages = [self.pageList count];
    
    self.scrollView.contentSize = CGSizeMake([self.pageList count]*SCREEN_WIDTH, SCREEN_HEIGHT);
    
    for(int i = 0; i < [self.pageList count]; i++){
        UIView *imageView = self.pageList[i];
        [imageView removeFromSuperview];
        imageView.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, frameHeight);
        [self.scrollView addSubview:imageView];
    }
}

-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd
{
    UIView *container = [[UIView alloc] initWithFrame:CGRectZero];
    [self.pageList insertObject:container atIndex:self.pageCtrl.currentPage];
    [self reloadPage];
    [self.interstitialAd presentInView:container];
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    for(UIView *item in self.pageList){
        if([item isMemberOfClass:[UIView class]]){
            [item removeFromSuperview];
            [self.pageList removeObject:item];
            [self reloadPage];
            break;
        }
    }
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

-(BOOL)interstitialAdActionShouldBegin:(ADInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"插页广告关闭");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageCtrl.currentPage = self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
}

- (IBAction)changePage:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.pageCtrl.currentPage*self.scrollView.frame.size.width, 0) animated:YES];
    }];
}



@end
