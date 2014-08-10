//
//  MapLocation.h
//  WhereAmI
//
//  Created by cavernyu on 14-6-5.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapLocation : NSObject<MKAnnotation>
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *zip;

@end
