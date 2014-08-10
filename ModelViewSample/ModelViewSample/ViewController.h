//
//  ViewController.h
//  ModelViewSample
//
//  Created by cavernyu on 13-12-25.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
- (IBAction)showModelView:(id)sender;

@end
