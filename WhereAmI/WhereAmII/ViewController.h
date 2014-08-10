//
//  ViewController.h
//  WhereAmI
//
//  Created by cavernyu on 14-6-4.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldLng;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLat;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAlt;
@property (nonatomic,strong) CLLocationManager *locationMgr;
- (IBAction)showLocation:(id)sender;

@end
