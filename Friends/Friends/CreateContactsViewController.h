//
//  CreateContactsViewController.h
//  Friends
//
//  Created by cavernyu on 14-5-28.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
@interface CreateContactsViewController : UIViewController <ABNewPersonViewControllerDelegate, ABUnknownPersonViewControllerDelegate>
- (IBAction)createNewPerson:(id)sender;
- (IBAction)createUnknownPerson:(id)sender;
- (IBAction)back:(id)sender;

@end
