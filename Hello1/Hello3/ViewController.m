//
//  ViewController.m
//  Hello3
//
//  Created by cavernyu on 13-10-31.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#import "NSString+URLEncoding.h"

@implementation ViewController

@synthesize webView = _webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *actionType = request.URL.host;
    NSString *scheme = request.URL.scheme;
    NSString *fragment = [request.URL.fragment URLDecodedString];
    NSData *responseData = [fragment dataUsingEncoding:NSUTF8StringEncoding];
    if([scheme isEqualToString:@"gap"]){
        if([actionType isEqualToString:@"XXXClass.XXXmethod"]){
            NSError *err;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            NSLog(@"title:%@, message:%@", [json objectForKey:@"title"], [json objectForKey:@"message"]);
        }
    }
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"helloworld('从ios对象中调用JS')"];
}

@end
