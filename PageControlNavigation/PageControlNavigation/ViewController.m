//
//  ViewController.m
//  PageControlNavigation
//
//  Created by cavernyu on 13-11-30.
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
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
    self.scrollView.frame = self.view.frame;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *page1ViewCtrller = [mainStoryboard instantiateViewControllerWithIdentifier:@"page1"];
    self.page1 = page1ViewCtrller.view;
    self.page1.frame = CGRectMake(0.0f, 0.0f, 320.f, 420.f);
    
    UIViewController *page2ViewCtrller = [mainStoryboard instantiateViewControllerWithIdentifier:@"page2"];
    self.page2 = page2ViewCtrller.view;
    self.page2.frame = CGRectMake(320.0f, 0.0f, 320.f, 420.f);
    
    UIViewController *page3ViewCtrller = [mainStoryboard instantiateViewControllerWithIdentifier:@"page3"];
    self.page3 = page3ViewCtrller.view;
    self.page3.frame = CGRectMake(2*320.0f, 0.0f, 320.f, 420.f);
    
    self.scrollView.delegate = self;
    
    [self.scrollView addSubview:self.page1];
    [self.scrollView addSubview:self.page2];
    [self.scrollView addSubview:self.page3];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageCtrl.currentPage = offset.x/320.0f;
    NSLog(@"currentPage: %li", (long)self.pageCtrl.currentPage);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePage:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        NSUInteger pageNum = self.pageCtrl.currentPage;
        self.scrollView.contentOffset = CGPointMake(320.0f*pageNum, 0.0f);
        
    }];
}
@end
