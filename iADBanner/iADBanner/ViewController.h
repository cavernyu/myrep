//
//  ViewController.h
//  iADBanner
//
//  Created by cavernyu on 14-6-10.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController<UIScrollViewDelegate,ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) UIImageView *imageView2;
@property (nonatomic,strong) UIImageView *imageView3;
@property (nonatomic,strong) UIImageView *imageView4;
@property (nonatomic,strong) ADBannerView *adBannerView;;
@property (nonatomic,assign) BOOL bannerIsVisible;
@property (nonatomic,assign) NSInteger pageNum;
- (IBAction)changePage:(id)sender;

@end
