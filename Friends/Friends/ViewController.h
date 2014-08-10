//
//  ViewController.h
//  Friends
//
//  Created by cavernyu on 14-5-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "CreateContactsViewController.h"
@interface ViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *names;
@property (nonatomic, strong) NSMutableArray *recordIDs;
@property (nonatomic, strong) CreateContactsViewController *ccViewController;

- (IBAction)addFriend:(id)sender;
- (IBAction)createContacts:(id)sender;

@end
