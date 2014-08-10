//
//  Animal.m
//  hello
//
//  Created by cavernyu on 13-10-18.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Animal.h"

@interface Animal (Private)

- (void) sleep;

@end

@implementation Animal

+ (void) initialize
{
    NSLog(@"进入类函数initialize");
}

- (void) setName:(NSString *) name
{
    self->_name = name;
}

- (NSString *) name
{
    
    return self->_name;
}

- (void) run
{
    NSLog(@"动物跑起来");
    [self sleep];
}

- (void) sleep
{
    NSLog(@"动物进入睡眠");
}

@end
