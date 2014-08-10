//
//  ViewController.h
//  Hello3
//
//  Created by cavernyu on 13-11-9.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSTimer *_timer;
}
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)testActivityIndicatorView:(id)sender;
- (IBAction)testProgressView:(id)sender;

@end
