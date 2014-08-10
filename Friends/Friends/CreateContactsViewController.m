//
//  CreateContactsViewController.m
//  Friends
//
//  Created by cavernyu on 14-5-28.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "CreateContactsViewController.h"

@interface CreateContactsViewController ()

@end

@implementation CreateContactsViewController

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
}

- (void)didReceiveMemoryWarning
{
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

- (IBAction)createNewPerson:(id)sender {
    ABNewPersonViewController *newPersonViewController = [[ABNewPersonViewController alloc] init];
    newPersonViewController.newPersonViewDelegate = self;
    UINavigationController *newNavigationController = [[UINavigationController alloc] initWithRootViewController:newPersonViewController];
    [self presentViewController:newNavigationController animated:YES completion:nil];
}

- (IBAction)createUnknownPerson:(id)sender {
    CFErrorRef err;
    ABRecordRef record = ABPersonCreate();
    ABRecordSetValue(record, kABPersonFirstNameProperty, @"yu", &err);
    
    ABMutableMultiValueRef emailProperty = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(emailProperty, @"cavernyu@126.com", kABWorkLabel, nil);
    ABMultiValueAddValueAndLabel(emailProperty, @"cavernyu@126.com", kABHomeLabel, nil);
    ABRecordSetValue(record, kABPersonEmailProperty, emailProperty, &err);
    if(emailProperty){
        CFRelease(emailProperty);
    }
    
    ABUnknownPersonViewController *unknownPersonViewController = [[ABUnknownPersonViewController alloc] init];
    unknownPersonViewController.unknownPersonViewDelegate = self;
    unknownPersonViewController.displayedPerson = record;
    unknownPersonViewController.allowsAddingToAddressBook = YES;
    
    if(record){
        CFRelease(record);
    }
    
    
    [self.navigationController pushViewController:unknownPersonViewController animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownCardViewController didResolveToPerson:(ABRecordRef)person
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
