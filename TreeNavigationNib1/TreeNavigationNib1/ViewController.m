//
//  ViewController1.m
//  TreeNavigationNib1
//
//  Created by cavernyu on 13-12-17.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#import "CitiesViewController.h"


@implementation ViewController

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
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces_cities" ofType:@"plist"];
    self.dictData = [NSDictionary dictionaryWithContentsOfFile:path];
    self.listData = [self.dictData allKeys];
    
    self.title = @"城市信息";
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesViewController *citiesViewController = [[CitiesViewController alloc] initWithStyle:UITableViewStylePlain];
    NSString *selectName = [self.listData objectAtIndex:indexPath.row];
    citiesViewController.listData = [self.dictData objectForKey:selectName];
    citiesViewController.title = selectName;
    [self.navigationController pushViewController:citiesViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
