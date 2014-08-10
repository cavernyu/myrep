//
//  ViewController.h
//  Hello2
//
//  Created by cavernyu on 13-10-30.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *_webView;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)loadHTMLString:(id)sender;

- (IBAction)loadData:(id)sender;

- (IBAction)loadRequest:(id)sender;


@end
