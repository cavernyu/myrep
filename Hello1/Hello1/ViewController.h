//
//  ViewController.h
//  Hello1
//
//  Created by cavernyu on 13-10-30.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
{
    __weak IBOutlet UILabel *_label1;
    __weak IBOutlet UISwitch *_leftSwitch;
    __weak IBOutlet UISwitch *_rightSwitch;
    __weak IBOutlet UILabel *_sliderLabel;
}


@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;

@property (weak, nonatomic) IBOutlet UILabel *label1;
- (IBAction)onClick:(id)sender;
- (IBAction)valueChanged:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)touchDown:(id)sender;


@end
