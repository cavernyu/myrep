//
//  ViewController.m
//  Hello4
//
//  Created by cavernyu on 13-11-7.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize textField = _textField;
@synthesize scrollView = _scrollView;
@synthesize keyboardVisible = _keyboardVisible;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(320, 600);
    self.scrollView.contentOffset = CGPointMake(0,100);
    // Do any additional setup after loading the view, typically from a nib.

}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [super viewWillDisappear:animated];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardDidShow:(NSNotification *)notify
{
    if(self.keyboardVisible)
        return;
    NSDictionary *dict = [notify userInfo];
    NSValue *val = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [val CGRectValue].size;
    
    CGRect scrollViewRect = self.scrollView.frame;
    scrollViewRect.size.height -= keyboardSize.height;
    self.scrollView.frame = scrollViewRect;
    
    CGRect textFieldRect = [self.textField frame];
    [self.scrollView scrollRectToVisible:textFieldRect animated:YES];
    
    
    self.keyboardVisible = YES;
}

-(void)keyboardDidHide:(NSNotification *)notify
{
    NSDictionary *dict = [notify userInfo];
    NSValue *val = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [val CGRectValue].size;
    
    CGRect rect = self.scrollView.frame;
    rect.size.height += keyboardSize.height;
    self.scrollView.frame = rect;
    
    if(!self.keyboardVisible)
        return;
    
    self.keyboardVisible = NO;
}



@end
