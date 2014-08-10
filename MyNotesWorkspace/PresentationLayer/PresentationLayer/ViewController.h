//
//  ViewController.h
//  PresentationLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteBL.h"
#import "Note.h"
#import "DetailViewController.h"
#import "AddViewController.h"

@interface ViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) AddViewController *addViewController;

@property (strong, nonatomic) UIButton *leftEditButton;

@property (assign, nonatomic) BOOL isVisible;


@property (assign, nonatomic) NSUInteger notesCount;

@property (strong, nonatomic) NSString *storeType;

@property (strong, nonatomic) NoteBL *noteBL;

@property (strong, nonatomic) NSMutableArray *noteList;

@end
