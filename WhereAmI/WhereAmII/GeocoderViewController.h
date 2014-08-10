//
//  GeocoderViewController.h
//  WhereAmI
//
//  Created by cavernyu on 14-6-5.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import <AddressBook/AddressBook.h>


@interface GeocoderViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *lngLabel;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *placemarkLabel;
- (IBAction)geocode:(id)sender;

@end
