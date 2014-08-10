//
//  MapLocation.m
//  WhereAmI
//
//  Created by cavernyu on 14-6-5.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "MapLocation.h"

@implementation MapLocation

-(NSString *)title
{
    return @"您的位置:";
}

-(NSString *)subtitle
{
    NSMutableString *subtitle = [[NSMutableString alloc] init];
    if(self.state){
        [subtitle appendString:self.state];
    }
    if(self.city){
        [subtitle appendString:self.city];
    }
    if(self.street){
        [subtitle appendString:self.street];
    }
    if(self.zip){
        [subtitle appendString:self.zip];
    }
    return subtitle;
}

@end
