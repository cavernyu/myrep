//
//  ViewController.m
//  Hello1
//
//  Created by cavernyu on 13-10-30.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize label1 = _label1;
@synthesize leftSwitch = _leftSwitch;
@synthesize rightSwitch = _rightSwitch;
@synthesize sliderLabel = _sliderLabel;

- (void)viewDidLoad{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    //注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardDidShowNotification object:nil];
    
    //注册键盘消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisappear:) name:UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated{
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    //解除键盘消失通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender {
    self.label1.text = @"helloworld!";
}

- (IBAction)valueChanged:(id)sender {
    UISwitch *_switch = (UISwitch *)sender;
    BOOL setting = _switch.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}

- (IBAction)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.sliderLabel.text = [NSString stringWithFormat:@"%.1f", slider.value];
    
}

- (IBAction)touchDown:(id)sender {
    if(self.leftSwitch.hidden == YES){
        self.rightSwitch.hidden = NO;
        self.leftSwitch.hidden = NO;
    }
    else{
        self.rightSwitch.hidden = YES;
        self.leftSwitch.hidden = YES;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void) keyboardAppear:(NSNotification *) notify{
    NSLog(@"键盘出现");
}

-(void) keyboardDisappear:(NSNotification *) notify{
    NSLog(@"键盘消失");
}

@end
