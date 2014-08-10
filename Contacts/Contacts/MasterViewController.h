//
//  MasterViewController.h
//  ReadContacts
//
//  Created by cavernyu on 14-5-16.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "DetailViewController.h"
@interface MasterViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic, strong) NSMutableArray *contacts;

@property (nonatomic, strong) DetailViewController *detailViewController;

-(void)filterContentForSearchText:(NSString*)searchText;

@end
