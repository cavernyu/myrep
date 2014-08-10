//
//  ModelViewController.h
//  NavigationComb
//
//  Created by cavernyu on 13-12-18.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)done:(id)sender;
- (IBAction)save:(id)sender;

@end
