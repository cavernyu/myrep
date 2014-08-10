//
//  ViewController.h
//  iAdFullScreen2
//
//  Created by cavernyu on 14-7-30.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <ADInterstitialAdDelegate>

@property (nonatomic, strong) UIImageView *page1;
@property (nonatomic, strong) UIImageView *page2;

@property (nonatomic, strong) ADInterstitialAd *interstitialAd;



- (IBAction)switchView:(id)sender;


@end
