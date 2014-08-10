//
//  CallMapViewController.h
//  WhereAmI
//
//  Created by cavernyu on 14-6-8.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import <MapKit/MapKit.h>

@interface CallMapViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)geocode:(id)sender;

@end
