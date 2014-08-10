//
//  FirstViewController.m
//  NavigationComb
//
//  Created by cavernyu on 13-12-18.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "FirstViewController.h"
#import "DetailViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces_cities" ofType:@"plist"];
    self.dictData = [NSDictionary dictionaryWithContentsOfFile:path];

    
    UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
    
    NSString *selectProvince = navigationController.tabBarItem.title;
    NSLog(@"%@", selectProvince);
    
    if([selectProvince isEqualToString:@"黑龙江"]){
        self.listData = [self.dictData objectForKey:@"黑龙江省"];
        self.navigationItem.title = @"黑龙江省信息";
    }else if([selectProvince isEqualToString:@"吉林"]){
        self.listData = [self.dictData objectForKey:@"吉林省"];
        self.navigationItem.title = @"吉林省信息";
    }else if([selectProvince isEqualToString:@"辽宁"]){
        self.listData = [self.dictData objectForKey:@"辽宁省"];
        self.navigationItem.title = @"辽宁省信息";
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dict = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DetailViewController *detailViewController = segue.destinationViewController;
    NSDictionary *dict = [self.listData objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    detailViewController.urlStr = [dict objectForKey:@"url"];
    detailViewController.title = [dict objectForKey:@"name"];
}



@end
