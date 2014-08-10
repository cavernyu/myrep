//
//  ViewController.m
//  IndexTable
//
//  Created by cavernyu on 13-11-26.
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"team_dictionary" ofType:@"plist"];
    self.dictData = [NSDictionary dictionaryWithContentsOfFile:path];
    self.group = [[self.dictData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.group count];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *groupName = [self.group objectAtIndex:section];
    NSArray *teams = [self.dictData objectForKey:groupName];
    return [teams count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    NSString *groupName = [self.group objectAtIndex:indexPath.section];
    NSArray *teams = [self.dictData objectForKey:groupName];
    cell.textLabel.text = [teams objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [teams objectAtIndex:indexPath.row];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.group objectAtIndex:section];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:[self.group count]];
    for(NSString *groupName in self.group){
        
        [tmpArr addObject:[groupName substringToIndex:1]];
    }
    return tmpArr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
