//
//  ViewController.m
//  Hello10
//
//  Created by cavernyu on 13-11-13.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"teams" ofType:@"plist"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.teams = [NSArray arrayWithContentsOfFile:path];
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    [self filterContentForSearchText:@"" scope:-1];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filterTeams count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }

    NSUInteger row = indexPath.row;

    NSDictionary *team = [self.filterTeams objectAtIndex:row];
    cell.textLabel.text = [team objectForKey:@"name"];
    cell.detailTextLabel.text = [team objectForKey:@"image"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[team objectForKey:@"image"] ofType:@"png"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSUInteger)scope
{
    if(!searchText || [searchText length] == 0){
        self.filterTeams = [NSMutableArray arrayWithArray:self.teams];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tmpArr;
    switch(scope){
        case 0:
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
            tmpArr = [self.teams filteredArrayUsingPredicate:scopePredicate];
            self.filterTeams = [NSMutableArray arrayWithArray:tmpArr];
            break;
        case 1:
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@", searchText];
            tmpArr = [self.teams filteredArrayUsingPredicate:scopePredicate];
            self.filterTeams = [NSMutableArray arrayWithArray:tmpArr];
            break;
        default:
            self.filterTeams = [NSMutableArray arrayWithArray:self.teams];
            break;
    }
    
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:self.searchBar.selectedScopeButtonIndex];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchBar.text scope:searchOption];
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self filterContentForSearchText:@"" scope:-1];
}

- (void)didReceiveMemoryWarning
{
    self.searchBar = nil;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
