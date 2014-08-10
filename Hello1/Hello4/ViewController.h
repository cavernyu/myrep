//
//  ViewController.h
//  Hello4
//
//  Created by cavernyu on 13-11-7.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UITextField *_textField;
    BOOL _keyboardVisible;
}
@property (nonatomic) BOOL keyboardVisible;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

-(void)keyboardDidShow:(NSNotification *)notify;

-(void)keyboardDidHide:(NSNotification *)notify;

@end
