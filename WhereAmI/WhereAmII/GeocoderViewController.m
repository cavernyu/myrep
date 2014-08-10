//
//  GeocoderViewController.m
//  WhereAmI
//
//  Created by cavernyu on 14-6-5.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "GeocoderViewController.h"

@interface GeocoderViewController ()

@end

@implementation GeocoderViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)geocode:(id)sender {
    if(!self.textField.text || self.textField.text.length == 0){
        return;
    }
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.textField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"%i", [placemarks count]);
        if([placemarks count] > 0){
            CLPlacemark *placemark = placemarks[0];
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            self.lngLabel.text = [NSString stringWithFormat:@"%3.5f", coordinate.longitude];
            self.latLabel.text = [NSString stringWithFormat:@"%3.5f", coordinate.latitude];
            NSDictionary *addressDict = placemark.addressDictionary;
            NSString *street = [addressDict objectForKey:(NSString*)kABPersonAddressStreetKey];
            street = street?street:@"";
            NSString *state = [addressDict objectForKey:(NSString*)kABPersonAddressStateKey];
            state = state?state:@"";
            NSString *city = [addressDict objectForKey:(NSString*)kABPersonAddressCityKey];
            city = city?city:@"";
            self.placemarkLabel.text = [NSString stringWithFormat:@"%@ %@ %@", state, city, street];
        }
    }];
}
@end
