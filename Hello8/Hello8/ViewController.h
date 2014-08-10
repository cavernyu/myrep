//
//  ViewController.h
//  Hello8
//
//  Created by cavernyu on 13-11-10.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) NSDictionary *pickerData;
@property (strong, nonatomic)
NSArray *pickerProvinces;
@property (strong, nonatomic) NSArray *pickerCities;

- (IBAction)onclick:(id)sender;

@end
