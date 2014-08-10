//
//  ViewController.m
//  Hello8
//
//  Created by cavernyu on 13-11-10.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"provinces_cities" ofType:@"plist"];
    
    self.pickerData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.pickerProvinces = [self.pickerData allKeys];
    self.pickerCities = [self.pickerData objectForKey:[self.pickerProvinces objectAtIndex:0]];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onclick:(id)sender {
    NSUInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSUInteger row2 = [self.pickerView selectedRowInComponent:1];
    NSString *selected1 = [self.pickerProvinces objectAtIndex:row1];
    NSString *selected2 = [self.pickerCities objectAtIndex:row2];
    NSString *desc = [NSString stringWithFormat:@"%@ %@", selected1, selected2];
    self.label.text = desc;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return [self.pickerProvinces count];
    }else{
        return [self.pickerCities count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        return [self.pickerProvinces objectAtIndex:row];
    }else{
        return [self.pickerCities objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0){
        self.pickerCities = [self.pickerData objectForKey:[self.pickerProvinces objectAtIndex:row]];
        [self.pickerView reloadComponent:1];
    }
}


@end
