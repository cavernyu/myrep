//
//  ViewController.h
//  Hello10
//
//  Created by cavernyu on 13-11-13.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *teams;

@property (strong, nonatomic) NSMutableArray *filterTeams;

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSUInteger)scope;

@end
