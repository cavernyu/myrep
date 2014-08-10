//
//  NoteViewController.h
//  XMLParse
//
//  Created by cavernyu on 14-5-29.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@interface NoteViewController : UITableViewController
@property (nonatomic, strong) Note *note;
@property (weak, nonatomic) IBOutlet UILabel *idetifierLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;



@end
