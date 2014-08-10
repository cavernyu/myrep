//
//  AddViewController.h
//  PresentationLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteBL.h"

@interface AddViewController : UITableViewController<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (assign, nonatomic) float keyboardFrameSizeHeight;

@property (strong, nonatomic) Note *note;


@end
