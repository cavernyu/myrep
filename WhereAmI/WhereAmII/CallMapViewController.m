//
//  CallMapViewController.m
//  WhereAmI
//
//  Created by cavernyu on 14-6-8.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "CallMapViewController.h"

@interface CallMapViewController ()

@end

@implementation CallMapViewController

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

- (IBAction)geocode:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.textField.text?self.textField.text:@"" completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count > 0){
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            NSLog(@"placemarks:%i", placemarks.count);
            for(int i = 0; i < placemarks.count; i++){
                CLPlacemark *placemark = placemarks[i];
                CLLocationCoordinate2D coordinate = placemark.location.coordinate;
                NSDictionary *addressDict = placemark.addressDictionary;
                MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:(coordinate) addressDictionary:addressDict];
                MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:place];
//                [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving}];
                [arr addObject:mapItem];
            }
            if(arr.count > 0){
                [MKMapItem openMapsWithItems:arr launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving}];
            }
        }
        
    }];
}
@end
