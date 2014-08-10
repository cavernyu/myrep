//
//  ReverseGeocoderViewController.m
//  WhereAmI
//
//  Created by cavernyu on 14-6-4.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "ReverseGeocoderViewController.h"

@interface ReverseGeocoderViewController ()

@end

@implementation ReverseGeocoderViewController

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
    self.locationMgr = [[CLLocationManager alloc] init];
    self.locationMgr.delegate = self;
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationMgr.distanceFilter = 1000.0f;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = [locations lastObject];
    self.textFieldLng.text = [NSString stringWithFormat:@"%3.5f", self.location.coordinate.longitude];
    self.textFieldLat.text = [NSString stringWithFormat:@"%3.5f", self.location.coordinate.latitude];
    self.textFieldAlt.text = [NSString stringWithFormat:@"%3.5f", self.location.altitude];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationErr:%@", [error localizedDescription]);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reverseGeocode:(id)sender {
    [self.locationMgr startUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(!error){
            CLPlacemark *placemark = placemarks[0];
            NSDictionary *addressDict = placemark.addressDictionary;
            NSString *street = [addressDict objectForKey:(NSString*)kABPersonAddressStreetKey];
            street = street?street:@"";
            NSString *state = [addressDict objectForKey:(NSString*)kABPersonAddressStateKey];
            state = state?state:@"";
            NSString *city = [addressDict objectForKey:(NSString*)kABPersonAddressCityKey];
            city = city?city:@"";
            self.textView.text = [NSString stringWithFormat:@"%@ %@ %@", state, city, street];
        }else{
            NSLog(@"reverseGeocodeLocationErr:%@", [error localizedDescription]);
        }
        
    }];
}
@end
