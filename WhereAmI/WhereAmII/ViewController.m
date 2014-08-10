//
//  ViewController.m
//  WhereAmI
//
//  Created by cavernyu on 14-6-4.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locationMgr = [[CLLocationManager alloc] init];
    self.locationMgr.delegate = self;
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationMgr.distanceFilter = 1000.0f;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.locationMgr stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.textFieldLat.text = [NSString stringWithFormat:@"%3.5f", location.coordinate.latitude];
    self.textFieldLng.text = [NSString stringWithFormat:@"%3.5f", location.coordinate.longitude];
    self.textFieldAlt.text = [NSString stringWithFormat:@"%3.5f", location.altitude];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

- (IBAction)showLocation:(id)sender {
    NSLog(@"%@", [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized?@"已授权":@"未授权");
    [self.locationMgr startUpdatingLocation];
}
@end
