//
//  ViewController.m
//  Friends
//
//  Created by cavernyu on 14-5-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.names = [[NSMutableArray alloc] init];
    self.recordIDs = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.names count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSString *name = [self.names objectAtIndex:indexPath.row];
    
    cell.textLabel.text = !name?@"":name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFErrorRef err;
    ABAddressBookRef abBook = ABAddressBookCreateWithOptions(NULL, &err);
    ABRecordID recordID = [[self.recordIDs objectAtIndex:indexPath.row] intValue];
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(abBook, recordID);
    
    ABPersonViewController *personView = [[ABPersonViewController alloc] init];
    personView.personViewDelegate = self;
    personView.displayedPerson = record;
    personView.allowsActions = NO;
    personView.allowsEditing = YES;
    personView.displayedProperties = @[[NSNumber numberWithInt:kABPersonEmailProperty], [NSNumber numberWithInt:kABPersonPhoneProperty]];
    
    [self.navigationController pushViewController:personView animated:YES];
    CFRelease(abBook);
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSString *name = (__bridge_transfer  NSString*)ABRecordCopyCompositeName(person);
    [self.names addObject:!name?@"":name];

    [self.recordIDs addObject:[NSNumber numberWithInt:ABRecordGetRecordID(person)]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
 
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.recordIDs.count - 1 inSection:0];

    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationRight];

    return NO;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}

- (IBAction)addFriend:(id)sender {
    ABPeoplePickerNavigationController *peoplePickerNavigationController = [[ABPeoplePickerNavigationController alloc] init];
    peoplePickerNavigationController.peoplePickerDelegate = self;
//    peoplePickerNavigationController.displayedProperties = @[[NSNumber numberWithInt:kABPersonEmailProperty], [NSNumber numberWithInt:kABPersonPhoneProperty], [NSNumber numberWithInt:kABPersonFirstNameProperty], [NSNumber numberWithInt:kABPersonLastNameProperty]];
    [self presentViewController:peoplePickerNavigationController animated:YES completion:nil];
    
}

- (IBAction)createContacts:(id)sender {
    self.ccViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateContactsViewController"];
    [self.navigationController pushViewController:self.ccViewController animated:YES];
}
@end
