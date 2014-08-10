//
//  AddViewController.m
//  Contacts
//
//  Created by cavernyu on 14-5-18.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "AddViewController.h"


@interface AddViewController ()

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    self.firstNameTextField.delegate = self;

    self.lastNameTextField.delegate = self;

    self.phoneIphoneTextField.delegate = self;

    self.phoneMobelTextField.delegate = self;

    self.emailHomeTextField.delegate = self;

    self.emailWorkTextField.delegate = self;

    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = self.scrollView.frame.size;

}

-(void)keyboardDidShow:(NSNotification*)notify
{
    NSValue *val = [notify.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [val CGRectValue];
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height - keyboardFrame.size.height);
}

-(void)keyboardDidHide:(NSNotification*)notify
{
    NSValue *val = [notify.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [val CGRectValue];
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height + keyboardFrame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)saveContact:(id)sender {
    CFErrorRef err;
    ABAddressBookRef abBook = ABAddressBookCreateWithOptions(NULL, &err);
    ABRecordRef record = ABPersonCreate();
    
    ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFTypeRef)(self.firstNameTextField.text == nil?@"":self.firstNameTextField.text), &err);
    ABRecordSetValue(record, kABPersonLastNameProperty, (__bridge CFTypeRef)(self.lastNameTextField.text == nil?@"":self.lastNameTextField.text), &err);
    
    ABMutableMultiValueRef phoneProperty = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phoneProperty, (__bridge CFTypeRef)(self.phoneIphoneTextField.text == nil?@"":self.phoneIphoneTextField.text), kABPersonPhoneIPhoneLabel, NULL);
    ABMultiValueAddValueAndLabel(phoneProperty, (__bridge CFTypeRef)(self.phoneMobelTextField.text == nil?@"":self.phoneMobelTextField.text), kABPersonPhoneMobileLabel, NULL);
    ABRecordSetValue(record, kABPersonPhoneProperty, phoneProperty, &err);
    if(phoneProperty){
        CFRelease(phoneProperty);
    }
   
    
    ABMutableMultiValueRef emailProperty = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(emailProperty, (__bridge CFTypeRef)(self.emailHomeTextField.text == nil?@"":self.emailHomeTextField.text), kABHomeLabel, NULL);
    ABMultiValueAddValueAndLabel(emailProperty, (__bridge CFTypeRef)(self.emailWorkTextField.text == nil?@"":self.emailWorkTextField.text), kABWorkLabel, NULL);
    ABRecordSetValue(record, kABPersonEmailProperty, emailProperty, &err);
    if(emailProperty){
        CFRelease(emailProperty);
    }
    
    
    ABAddressBookAddRecord(abBook, record, &err);
    ABAddressBookSave(abBook, &err);
    if(record){
        CFRelease(record);
    }
    if(abBook){
        CFRelease(abBook);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [[[UIAlertView alloc] initWithTitle:@"save contact" message:@"Done" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
}

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.scrollView scrollRectToVisible:textField.frame animated:YES];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
