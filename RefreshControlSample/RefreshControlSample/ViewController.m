//
//  ViewController.m
//  RefreshControlSample
//
//  Created by cavernyu on 13-11-29.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.logs = [[NSMutableArray alloc] init];
    NSDate *date = [[NSDate alloc] init];
    [self.logs addObject:date];
    
    
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    
    
}

-(void)refreshTableView
{
    if(self.refreshControl.refreshing){
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中..."];
        NSDate *date = [[NSDate alloc] init];
        [self performSelector:@selector(callBackMethod:) withObject:date afterDelay:3];
    }
}

-(void)callBackMethod:(id)obj
{
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.logs addObject:(NSDate *)obj];
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.logs count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    NSDateFormatter *dtFormatter = [[NSDateFormatter alloc]init];
    [dtFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    cell.textLabel.text = [dtFormatter stringFromDate:[self.logs objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
