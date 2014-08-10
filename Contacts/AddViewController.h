//
//  AddViewController.h
//  Contacts
//
//  Created by cavernyu on 14-5-18.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface AddViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailHomeTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailWorkTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneIphoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneMobelTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

- (IBAction)saveContact:(id)sender;
- (IBAction)cancelClicked:(id)sender;

@end
