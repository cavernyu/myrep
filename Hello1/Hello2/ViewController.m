//
//  ViewController.m
//  Hello2
//
//  Created by cavernyu on 13-10-30.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize webView = _webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadHTMLString:(id)sender {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *bundleURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *err = nil;
    NSString *html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&err];
    if(!err){
        [self.webView loadHTMLString:html baseURL:bundleURL];
    }
}

- (IBAction)loadData:(id)sender {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *bundleURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *err = nil;
    NSData *data = [NSData dataWithContentsOfFile:htmlPath];
    if(!err){
        [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:bundleURL];
    }
}

- (IBAction)loadRequest:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
}

@end
