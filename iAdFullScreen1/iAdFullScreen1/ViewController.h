//
//  ViewController.h
//  iAdFullScreen1
//
//  Created by cavernyu on 14-7-29.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <UIScrollViewDelegate, ADInterstitialAdDelegate>
@property (nonatomic, strong) NSMutableArray *pageList;
@property (nonatomic, strong) ADInterstitialAd *interstitialAd;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
- (IBAction)changePage:(id)sender;

@end
