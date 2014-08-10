//
//  Wife.m
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Wife.h"

@implementation Wife
@synthesize name = _name;
-(void) beAskedBuyFood:(void (^)(void))_callBackToHusband
{
    NSLog(@"老婆被老公叫去买吃的");
    callBackToHusband = _callBackToHusband;
    if(callBackToHusband)
    {
        callBackToHusband();
    }
        
    
    
}

@end
