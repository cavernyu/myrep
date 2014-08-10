//
//  RegisterViewController.h
//  ModalViewSample
//
//  Created by cavernyu on 13-11-30.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
- (IBAction)done:(id)sender;

@end
