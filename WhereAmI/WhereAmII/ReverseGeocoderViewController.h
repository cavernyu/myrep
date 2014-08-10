//
//  ReverseGeocoderViewController.h
//  WhereAmI
//
//  Created by cavernyu on 14-6-4.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLPlacemark.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <AddressBook/AddressBook.h>

@interface ReverseGeocoderViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldLng;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLat;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAlt;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) CLLocationManager *locationMgr;
@property (nonatomic, strong) CLLocation *location;
- (IBAction)reverseGeocode:(id)sender;

@end
