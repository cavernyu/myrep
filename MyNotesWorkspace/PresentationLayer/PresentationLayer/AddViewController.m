//
//  AddViewController.m
//  PresentationLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (strong, nonatomic) NSString *imagePath;
@property (strong, nonatomic) NSString *languageID;
@end

@implementation AddViewController

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
    
    
    self.navigationItem.title = NSLocalizedString(@"增加", @"增加");
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"9.png"]] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"10.png"]] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(saveNote) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.titleTextField.delegate = self;
    self.contentTextView.delegate = self;
    
    
    [[self.titleTextField superview] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"19.png"]]]];
    [self.titleTextField setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"17.png"]]]];
    [self.contentTextView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:@"18.png"]]]];
    
    
    [self.tableView setScrollEnabled:NO];
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.note = [[Note alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange:) name:NSCurrentLocaleDidChangeNotification object:nil];
    
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

-(void)keyboardDidShow:(NSNotification *)notify
{
    if(self.keyboardFrameSizeHeight == 0){
        NSDictionary *dict = notify.userInfo;
        NSValue *val = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrame = [val CGRectValue];
        self.keyboardFrameSizeHeight = keyboardFrame.size.height;
    }
    self.contentTextView.frame = CGRectMake(0, 0, self.contentTextView.frame.size.width, self.contentTextView.frame.size.height - self.keyboardFrameSizeHeight + 50);
}

-(void)keyboardDidHide:(NSNotification *)notify
{
    self.contentTextView.frame = CGRectMake(0, 0, self.contentTextView.frame.size.width, self.contentTextView.frame.size.height + self.keyboardFrameSizeHeight - 50);
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.note.title = textField.text == nil?string:[NSString stringWithFormat:@"%@%@", textField.text, string];
    if([[self.note.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]){
        self.note.title = nil;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.note.content = textView.text == nil?@"":textView.text;
}

-(void)textViewDidChangeSelection:(UITextView *)textView
{
    CGRect caretRect = [self.contentTextView caretRectForPosition:self.contentTextView.selectedTextRange.start];
    [self.contentTextView scrollRectToVisible:caretRect animated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSCurrentLocaleDidChangeNotification object:nil];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveNote{
    UIAlertView *alertView;
    if(self.note){
        self.note.date = [[NSDate alloc] init];
        NoteBL *noteBL = [[NoteBL alloc] init];
        
        [noteBL createNote:self.note];
        alertView = [[UIAlertView alloc] initWithTitle:@"保存" message:@"保存成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        alertView = [[UIAlertView alloc] initWithTitle:@"保存" message:@"备忘录不存在,保存不成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView
         show];
    }
    
}

- (void)cancelClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
