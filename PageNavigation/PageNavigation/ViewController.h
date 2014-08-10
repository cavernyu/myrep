//
//  ViewController.h
//  PageNavigation
//
//  Created by cavernyu on 13-12-1.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    int pageIndex;
}
@property (strong, nonatomic) UIPageViewController *pageViewCtrl;

@end
