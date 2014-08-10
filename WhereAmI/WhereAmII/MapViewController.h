//
//  MapViewController.h
//  WhereAmI
//
//  Created by cavernyu on 14-6-5.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import "MapLocation.h"

@interface MapViewController : UIViewController<MKMapViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)query:(id)sender;

@end
