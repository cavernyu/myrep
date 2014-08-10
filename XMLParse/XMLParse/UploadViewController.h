//
//  UploadViewController.h
//  XMLParse
//
//  Created by cavernyu on 14-6-3.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "NSString+URLEncoding.h"

@interface UploadViewController : UIViewController<ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)upload:(id)sender;

@end
