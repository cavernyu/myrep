//
//  DetailViewController.h
//  TreeNavigationStoryboard
//
//  Created by cavernyu on 13-12-17.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *urlStr;

@end
