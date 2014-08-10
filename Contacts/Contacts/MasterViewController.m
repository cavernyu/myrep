//
//  MasterViewController.m
//  ReadContacts
//
//  Created by cavernyu on 14-5-16.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "MasterViewController.h"



@interface MasterViewController () {
    
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    CFErrorRef err;
    ABAddressBookRef abBook = ABAddressBookCreateWithOptions(NULL, &err);
    ABAddressBookRequestAccessWithCompletion(abBook, ^(bool granted, CFErrorRef error) {
        if(granted){
            [self filterContentForSearchText:@""];
        }
    });
    if(abBook){
        CFRelease(abBook);
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self filterContentForSearchText:@""];
}

-(void)filterContentForSearchText:(NSString *)searchText
{
    if(ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized){
        return;
    }
    CFErrorRef err;
    ABAddressBookRef abBook = ABAddressBookCreateWithOptions(NULL, &err);
    if(!searchText || [searchText isEqualToString:@""]){
        self.contacts = [[NSMutableArray alloc] initWithArray:(__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(abBook)];
    }else{
        CFStringRef searchTextRef = (__bridge_retained  CFStringRef)searchText;
        self.contacts = [[NSMutableArray alloc] initWithArray:(__bridge_transfer NSArray*)ABAddressBookCopyPeopleWithName(abBook, searchTextRef)];
        if(searchTextRef){
            CFRelease(searchTextRef);
        }
        
    }
    if(abBook){
        CFRelease(abBook);
    }
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    ABRecordRef record = (__bridge_retained ABRecordRef)[self.contacts objectAtIndex:indexPath.row];
    NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(record, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(record, kABPersonLastNameProperty);
    
    firstName = firstName == nil?@"":firstName;
    lastName = lastName == nil?@"":lastName;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(record){
        CFRelease(record);
    }
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(self.contacts && [self.contacts count] > 0){
            CFErrorRef err;
            ABAddressBookRef abBook = ABAddressBookCreateWithOptions(NULL, &err);
            ABRecordRef record = (__bridge_retained ABRecordRef)[self.contacts objectAtIndex:indexPath.row];
            ABRecordID recordID = ABRecordGetRecordID(record);
            ABRecordRef person = ABAddressBookGetPersonWithRecordID(abBook, recordID);
            ABAddressBookRemoveRecord(abBook, person, &err);
            ABAddressBookSave(abBook, &err);
            [self.contacts removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            if(record){
                CFRelease(record);
            }
            if(abBook){
                CFRelease(abBook);
            }
        }
        
    }
    
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    ABRecordRef record = (__bridge_retained ABRecordRef)[self.contacts objectAtIndex:indexPath.row];
    ABRecordID recordID = ABRecordGetRecordID(record);
    NSNumber *personID = [NSNumber numberWithInt:recordID];
    [self.detailViewController setDetailItem:personID];
    if(record){
        CFRelease(record);
    }
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self filterContentForSearchText:@""];
}

@end
