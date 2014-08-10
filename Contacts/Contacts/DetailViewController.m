//
//  DetailViewController.m
//  ReadContacts
//
//  Created by cavernyu on 14-5-16.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    ABRecordID recordID = [(NSNumber*)self.detailItem intValue];
    CFErrorRef err;
    ABAddressBookRef abBook = ABAddressBookCreateWithOptions(NULL, &err);
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(abBook, recordID);
    
    ABMultiValueRef emailProperty = ABRecordCopyValue(record, kABPersonEmailProperty);
    NSArray *emails = (__bridge_transfer NSArray*)ABMultiValueCopyArrayOfAllValues(emailProperty);
    for(int i = 0; i < [emails count]; i++){
        NSString *email = [emails objectAtIndex:i];
        NSString *emailLabel = (__bridge_transfer NSString*)ABMultiValueCopyLabelAtIndex(emailProperty, i);
        
        if([emailLabel isEqualToString:(__bridge_transfer NSString*)kABWorkLabel]){
            self.email1.text = [NSString stringWithFormat:@"%@:%@",emailLabel, email];
        }else if([emailLabel isEqualToString:(__bridge_transfer NSString*)kABHomeLabel]){
            self.email2.text = [NSString stringWithFormat:@"%@:%@",emailLabel, email];
        }else{
            NSLog(@"%@:%@",emailLabel, email);
        }
    }
    if(emailProperty){
        CFRelease(emailProperty);
    }
    
    
    ABMultiValueRef phoneProperty = ABRecordCopyValue(record, kABPersonPhoneProperty);
    NSArray * phones = (__bridge_transfer NSArray*)ABMultiValueCopyArrayOfAllValues(phoneProperty);
    for(int i = 0; i < [phones count]; i++){
        NSString *phone = [phones objectAtIndex:i];
        NSString *phoneLabel = (__bridge_transfer NSString*)ABMultiValueCopyLabelAtIndex(phoneProperty, i);
        
        if([phoneLabel isEqualToString:(__bridge_transfer NSString*)kABPersonPhoneMobileLabel]){
            self.tel1.text = [NSString stringWithFormat:@"%@:%@",phoneLabel, phone];
        }else if([phoneLabel isEqualToString:(__bridge_transfer NSString*)kABPersonPhoneIPhoneLabel]){
            self.tel2.text = [NSString stringWithFormat:@"%@:%@",phoneLabel, phone];
        }else{
            NSLog(@"%@:%@",phoneLabel, phone);
        }
    }
    if(phoneProperty){
        CFRelease(phoneProperty);
    }
    
    
    NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(record, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(record, kABPersonLastNameProperty);
    self.name.text = [NSString stringWithFormat:@"%@ %@", !firstName?@"":firstName, !lastName?@"":lastName];
    
    if(ABPersonHasImageData(record)){
        NSData *imageData = (__bridge_transfer NSData*)ABPersonCopyImageData(record);
        if(imageData){
            self.personImage.image = [UIImage imageWithData:imageData];
        }
    }

    if(abBook){
        CFRelease(abBook);
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
