//
//  TrackViewController.m
//  WhereAmI
//
//  Created by cavernyu on 14-6-6.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "TrackViewController.h"

@interface TrackViewController ()

@end

@implementation TrackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([CLLocationManager locationServicesEnabled]){
        self.mapView.mapType = MKMapTypeStandard;
        self.mapView.delegate = self;
        self.mapView.showsUserLocation = YES;
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate = userLocation.coordinate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
