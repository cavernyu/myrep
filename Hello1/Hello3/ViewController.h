//
//  ViewController.h
//  Hello3
//
//  Created by cavernyu on 13-10-31.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *_webView;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
