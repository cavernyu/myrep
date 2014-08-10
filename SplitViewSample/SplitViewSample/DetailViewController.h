//
//  DetailViewController.h
//  SplitViewSample
//
//  Created by cavernyu on 13-12-19.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowViewController.h"
#import "BlueViewController.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) YellowViewController *yellowViewController;
@property (strong, nonatomic) BlueViewController *blueViewController;

-(void) updateView:(NSInteger) row;
@end
