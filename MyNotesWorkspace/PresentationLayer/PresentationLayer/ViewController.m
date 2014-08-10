//
//  ViewController.m
//  PresentationLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#define CellIdentifier @"notesCell"


@interface ViewController ()
@property (strong, nonatomic) NSString *imagePath;
@property (strong, nonatomic) NSString *languageID;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imagePath = nil;
    self.languageID = [[NSLocale currentLocale] localeIdentifier];
    if([self.languageID isEqualToString:@"en_US"]){
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }else if ([self.languageID isEqualToString:@"zh_Hans_CN"]){
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
    }else{
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"14.png"]]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"18.png"]]];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"1.png"]] stretchableImageWithLeftCapWidth:1 topCapHeight:5] forBarMetrics:UIBarMetricsDefault];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [rightButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"3.png"]] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }else{
        self.clearsSelectionOnViewWillAppear = NO;
    }
    
    self.leftEditButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.leftEditButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"7.png"]] forState:UIControlStateNormal];
    [self.leftEditButton addTarget:self action:@selector(editChangeToDone) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftEditButton];
    
    UIRefreshControl *refreshCtrl = [[UIRefreshControl alloc] init];
    refreshCtrl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"下拉刷新", @"下拉刷新")];
    [refreshCtrl addTarget:self action:@selector(refreshNotes) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshCtrl;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange:) name:NSCurrentLocaleDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUserDefaults:) name:NSUserDefaultsDidChangeNotification object:nil];
    
    self.noteBL = [[NoteBL alloc] init];
    self.noteList = [self.noteBL findAll];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftEditButton];
    
    self.isVisible = NO;
}

-(void)localeDidChange:(NSNotification*)notify
{
    self.languageID = [[NSLocale currentLocale] localeIdentifier];
    if([self.languageID isEqualToString:@"en_US"]){
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }else if ([self.languageID isEqualToString:@"zh-Hans"]){
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
    }else{
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }
}

-(void)reloadUserDefaults:(NSNotification*)notify
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.storeType = [userDefaults stringForKey:@"storeType_preference"];
    //    NSLog(@"%@%@", [userDefaults objectIsForcedForKey:@"storeType_preference"]?@"YES":@"NO", self.storeType);
}

-(void)refreshNotes
{
    if([self.refreshControl isRefreshing]){
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"正在刷新...", @"正在刷新...")];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"16.png"]]];
        [self performSelector:@selector(reloadNotes) withObject:nil afterDelay:0.5f];
    }
    
}

-(void)reloadNotes
{
    [self.refreshControl endRefreshing];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"14.png"]]];
    self.noteList = [self.noteBL findAll];
    [self.tableView reloadData];
}

-(void)addNote
{
    self.addViewController = [self.storyboard instantiateViewControllerWithIdentifier:[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone?@"AddViewController_iphone":@"AddViewController_ipad"];
    [self.navigationController pushViewController:self.addViewController animated:YES];
}

-(void)editChangeToDone
{
    
    UIButton *leftDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftDoneButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"8.png"]] forState:UIControlStateNormal];
    [leftDoneButton addTarget:self action:@selector(doneChangeToEdit) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftDoneButton];
    self.isVisible = YES;
    [self.tableView reloadData];
    
}

-(void)doneChangeToEdit
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftEditButton];
    self.isVisible = NO;
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.notesCount = [self.noteList count];
    return self.notesCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Note *noteTemp = [self.noteList objectAtIndex:(self.notesCount - indexPath.row - 1)];
    
    cell.textLabel.text = noteTemp.title == nil?NSLocalizedString(@"空", @"空"):noteTemp.title;
    if(cell.textLabel.text.length > 10){
        cell.textLabel.text = [NSString stringWithFormat:@"%@...", [cell.textLabel.text substringToIndex:9]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    cell.detailTextLabel.text = noteTemp.date == nil?NSLocalizedString(@"空", @"空"):[dateFormatter stringFromDate:noteTemp.date];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    if([[cell.contentView.subviews lastObject] isKindOfClass:[UIButton class]] ){
        UIButton *delButton = [cell.contentView.subviews lastObject];
        [delButton setHidden:self.isVisible?NO:YES];
        delButton.tag = indexPath.row;
    }else{
        UIButton *delButton = [[UIButton alloc] initWithFrame:CGRectMake(250, cell.contentView.frame.origin.y+5, 50, 30)];
        [delButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"13.png"]] forState:UIControlStateNormal];
        [delButton addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
        delButton.tag = indexPath.row;
        [delButton setHidden:self.isVisible?NO:YES];
        [cell.contentView addSubview:delButton];
    }
    return cell;
}

-(void)deleteCell:(id)sender
{
    UIButton *delButton = (UIButton *)sender;
    ;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:delButton.tag inSection:0];
    
    [self.noteBL removeNoteAtindex:(self.notesCount - indexPath.row - 1) orById:[self.noteList objectAtIndex:(self.notesCount - indexPath.row - 1)]];
    [self.noteList removeObjectAtIndex:(self.notesCount - indexPath.row - 1)];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView reloadData];
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [segue.identifier isEqualToString:@"showDetail"]){
//        NSLog(@"1!!!!!!");
//        self.detailViewController = [segue destinationViewController];
//        self.detailViewController.note = [self.noteList objectAtIndex:(self.notesCount - [[self.tableView indexPathForSelectedRow] row] - 1)];
//    }
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
        self.detailViewController.note = [self.noteList objectAtIndex:(self.notesCount - indexPath.row - 1)];
    }else{
        self.detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController_iphone"];
        self.detailViewController.note = [self.noteList objectAtIndex:(self.notesCount - indexPath.row - 1)];
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSCurrentLocaleDidChangeNotification object:nil];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
