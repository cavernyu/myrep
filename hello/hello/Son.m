//
//  Son.m
//  hello
//
//  Created by cavernyu on 13-10-23.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Son.h"

@implementation Son
@synthesize age = _age;
-(id) init
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateAge) userInfo:nil repeats:YES];
    return self;
    
}

-(void) updateAge
{
    self.age += 1;
}

@end
