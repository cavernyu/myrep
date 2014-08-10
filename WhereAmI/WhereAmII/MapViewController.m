//
//  MapViewController.m
//  WhereAmI
//
//  Created by cavernyu on 14-6-5.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.delegate = self;
    self.textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)query:(id)sender {
    if(!self.textField.text || self.textField.text.length == 0){
        return;
    }else{
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:self.textField.text completionHandler:^(NSArray *placemarks, NSError *error) {
            if(placemarks && placemarks.count > 0){
                [self.mapView removeAnnotations:self.mapView.annotations];
                for(int i = 0; i < placemarks.count; i++){
                    CLPlacemark *placemark = placemarks[i];
                    MKCoordinateRegion viewRegin = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 1000, 1000);
                    [self.mapView setRegion:viewRegin animated:YES];
                    MapLocation *annotation = [[MapLocation alloc] init];
                    annotation.street = placemark.thoroughfare;
                    annotation.city = placemark.locality;
                    annotation.state = placemark.administrativeArea;
                    annotation.zip = placemark.postalCode;
                    annotation.coordinate = placemark.location.coordinate;
                    [self.mapView addAnnotation:annotation];
                }
            }
            
        }];
    }
}

-(void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNATATION"];
    if(!annotationView){
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNATATION"];
    }
    annotationView.pinColor = MKPinAnnotationColorRed;
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    return annotationView;
}

@end
