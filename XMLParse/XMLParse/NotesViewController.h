//
//  NotesViewController.h
//  XMLParse
//
//  Created by cavernyu on 14-5-29.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteViewController.h"
@interface NotesViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *notes;

@property (nonatomic, strong) NoteViewController *noteViewController;
- (IBAction)back:(id)sender;

@end
