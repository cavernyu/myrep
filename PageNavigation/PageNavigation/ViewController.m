//
//  ViewController.m
//  PageNavigation
//
//  Created by cavernyu on 13-12-1.
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
    self.view.frame = CGRectMake(0.0f, 0.0f, 320.0f, 440.0f);
    
    self.pageViewCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewCtrl.dataSource = self;
    self.pageViewCtrl.delegate = self;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *page1ViewCtrl = [mainStoryboard instantiateViewControllerWithIdentifier:@"page1"];
    
    NSArray *viewCtrls = @[page1ViewCtrl];
    [self.pageViewCtrl setViewControllers:viewCtrls direction:UIPageViewControllerNavigationDirectionForward animated:YES
                               completion:nil];
    
    
    [self.view addSubview:self.pageViewCtrl.view];
    pageIndex = 0;
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    pageIndex--;
    if(pageIndex < 0){
        pageIndex = 0;
        return nil;
    }
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSString *pageId = [NSString stringWithFormat:@"page%i", pageIndex+1];
    UIViewController *pvCtrl = [mainStoryboard instantiateViewControllerWithIdentifier:pageId];
    return pvCtrl;
}


-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    pageIndex++;
    if(pageIndex > 2){
        pageIndex = 2;
        return nil;
    }
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSString *pageId = [NSString stringWithFormat:@"page%i", pageIndex+1];
    UIViewController *pvCtrl = [mainStoryboard instantiateViewControllerWithIdentifier:pageId];
    return pvCtrl;
}

-(UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
   
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *page1ViewCtrl = [mainStoryboard instantiateViewControllerWithIdentifier:@"page1"];
    UIViewController *page2ViewCtrl = [mainStoryboard instantiateViewControllerWithIdentifier:@"page2"];
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
        NSArray *viewCtrls = @[page1ViewCtrl, page2ViewCtrl];
        [self.pageViewCtrl setViewControllers:viewCtrls direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        self.pageViewCtrl.doubleSided = YES;
        return UIPageViewControllerSpineLocationMid;
    }
    
    NSArray *viewCtrls = @[page1ViewCtrl];
    [self.pageViewCtrl setViewControllers:viewCtrls direction:UIPageViewControllerNavigationDirectionForward animated:YES
                               completion:nil];
    self.pageViewCtrl.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
