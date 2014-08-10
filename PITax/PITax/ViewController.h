//
//  ViewController.h
//  PITax
//
//  Created by cavernyu on 14-8-4.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)onclick:(id)sender;

-(NSString*)calculate:(NSString*)revenue;
@end
