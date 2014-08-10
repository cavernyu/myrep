//
//  ViewController.m
//  iADBanner
//
//  Created by cavernyu on 14-6-10.
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
    self.pageControl.numberOfPages = 4;
    
    self.pageNum = 0;
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = CGSizeMake(4*320, 420);
    self.imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-1.png"]];
    self.imageView1.frame = CGRectMake(0, 0, 320, 420);
    self.imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-2.png"]];
    self.imageView2.frame = CGRectMake(320, 0, 320, 420);
    self.imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-3.png"]];
    self.imageView3.frame = CGRectMake(320*2, 0, 320, 420);
    self.imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal-4.png"]];
    self.imageView4.frame = CGRectMake(320*3, 0, 320, 420);
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView addSubview:self.imageView3];
    [self.scrollView addSubview:self.imageView4];
    
    self.scrollView.delegate = self;
    
    if([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]){
        self.adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        
        self.adBannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }else{
        self.adBannerView = [[ADBannerView alloc] init];
    }
    
    self.adBannerView.delegate = self;
    
    [self.view insertSubview:self.adBannerView aboveSubview:self.scrollView];
}

-(void)viewDidLayoutSubviews
{
    [self layoutAnimated:[UIView areAnimationsEnabled]];
}

-(void)layoutAnimated:(BOOL)animated{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
    CGRect contentFrame = self.view.bounds;
    if(contentFrame.size.width < contentFrame.size.height){
        self.adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    }else{
        self.adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    }
    
#endif
    CGRect bannerFrame = self.adBannerView.frame;
    if(self.adBannerView.bannerLoaded){
        bannerFrame.origin.y = 0;
    }else{
        bannerFrame.origin.y -= self.adBannerView.frame.size.height;
    }
    [UIView animateWithDuration:animated?0.25:0.0 animations:^{
        self.adBannerView.frame = bannerFrame;
    }];

}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0_0
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
#endif

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollView.contentOffset.x/320;
}

- (IBAction)changePage:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage*320, 0);
    }];
    
}
@end
