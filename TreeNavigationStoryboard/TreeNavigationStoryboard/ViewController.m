//
//  ViewController.m
//  TreeNavigationStoryboard
//
//  Created by cavernyu on 13-12-17.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#import "CitiesViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowSelectedProvince"]){
        
        CitiesViewController *citiesViewController = segue.destinationViewController;

        NSString *selectedName = [self.listData objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        citiesViewController.listData = [self.dictData objectForKey:selectedName];
        
        citiesViewController.title = selectedName;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
