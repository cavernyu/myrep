//
//  ViewController.h
//  PageControlNavigation
//
//  Created by cavernyu on 13-11-30.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (strong, nonatomic) UIView *page1;
@property (strong, nonatomic) UIView *page2;
@property (strong, nonatomic) UIView *page3;

- (IBAction)changePage:(id)sender;


@end
