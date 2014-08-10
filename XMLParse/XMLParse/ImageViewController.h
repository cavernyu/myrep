//
//  ImageViewController.h
//  XMLParse
//
//  Created by cavernyu on 14-6-2.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "NSString+URLEncoding.h"

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong) ASINetworkQueue *queue;
- (IBAction)go:(id)sender;

@end
