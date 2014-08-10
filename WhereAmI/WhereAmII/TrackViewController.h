//
//  TrackViewController.h
//  WhereAmI
//
//  Created by cavernyu on 14-6-6.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>

@interface TrackViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
