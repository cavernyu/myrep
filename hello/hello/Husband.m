//
//  Husband.m
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Husband.h"

@implementation Husband
@synthesize name = _name;
@synthesize wife = _wife;
- (void) askWifeBuyFood
{
    if(self.wife){
        [self.wife beAskedBuyFood:^(void) {
            NSLog(@"老婆跟老公要钱");
        }];
    }
}

@end
