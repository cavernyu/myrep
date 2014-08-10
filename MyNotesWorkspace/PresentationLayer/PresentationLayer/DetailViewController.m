//
//  DetailViewController.m
//  PresentationLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) NSString *imagePath;
@property (strong, nonatomic) NSString *languageID;
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setNote:(Note *)note
{
    if(_note != note){
        _note = note;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            self.titleLabel.text = _note == nil?@"":_note.title;
            self.contentTextView.text = _note == nil?@"":_note.content;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            self.dateLabel.text = _note == nil?@"":[dateFormatter stringFromDate:_note.date];
            if(self.masterPopCtrl){
                [self.masterPopCtrl dismissPopoverAnimated:YES];
            }
        }
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.imagePath = nil;
    self.languageID = [[NSLocale currentLocale] localeIdentifier];
    if([self.languageID isEqualToString:@"en_US"]){
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }else if ([self.languageID isEqualToString:@"zh_Hans_CN"]){
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
    }else{
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [leftButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"12.png"]] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }else{
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [leftButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"21.png"]] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(masterClicked) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [rightButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"3.png"]] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"1.png"]] stretchableImageWithLeftCapWidth:0 topCapHeight:5] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    self.navigationItem.title = NSLocalizedString(@"详细", @"详细");
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        self.titleLabel.text = self.note == nil?@"":self.note.title;
        self.contentTextView.text = self.note == nil?@"":self.note.content;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        self.dateLabel.text = self.note == nil?@"":[dateFormatter stringFromDate:self.note.date];
    }
    
    [[self.titleLabel superview] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"19.png"]]]];
    
    [self.contentTextView setEditable:NO];
    [self.contentTextView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"18.png"]]]];
    
    [[self.dateLabel superview] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"19.png"]]]];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange:) name:NSCurrentLocaleDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSCurrentLocaleDidChangeNotification object:nil];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)addNote
{
    self.addViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController_ipad"];
    
    [self.navigationController pushViewController:self.addViewController animated:YES];
}

-(void)masterClicked{
    if(self.masterPopCtrl){
        [self.masterPopCtrl presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    }
}

- (void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"21.png"]] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(masterClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftButton] animated:YES];
    self.masterPopCtrl = pc;
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopCtrl = nil;
}

@end
