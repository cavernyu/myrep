//
//  ViewController.m
//  DeleteAddCell
//
//  Created by cavernyu on 13-11-27.
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
    self.navgItem.rightBarButtonItem = self.editButtonItem;
    self.navgItem.title = @"单元格插入和删除";
    self.textField.hidden = YES;
    self.textField.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.teams = [NSMutableArray arrayWithObjects:@"黑龙江", @"吉林", @"辽林", @"厦门", @"广州", @"北京", @"武汉", @"上海", nil];
    
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    if(editing){
        self.textField.hidden = NO;
        
    }else{
        self.textField.hidden = YES;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teams count]+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if(indexPath.row != [self.teams count]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [self.teams objectAtIndex:indexPath.row];
    }else{
        self.textField.frame = CGRectMake(10, 0, 300, 44);
        self.textField.text = @"";
        [cell.contentView addSubview:self.textField];
    }
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [self.teams count]){
        return UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.teams removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        [self.teams insertObject:self.textField.text atIndex:[self.teams count]];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [self.teams count]){
        return NO;
    }else{
        return YES;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    UITableViewCell *cell = (UITableViewCell*)[[textField superview] superview];
    [self.tableView setContentOffset:CGPointMake(0.0f, cell.frame.origin.y) animated:YES];
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *tmpStr = [self.teams objectAtIndex:sourceIndexPath.row];
    [self.teams removeObjectAtIndex:sourceIndexPath.row];
    [self.teams insertObject:tmpStr atIndex:destinationIndexPath.row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
