//
//  Animal+Animal.m
//  hello
//
//  Created by cavernyu on 13-10-18.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Animal+Animal.h"

@implementation Animal (Animal)

- (void) setAge:(int)age
{
    self->_age = age;
}

- (int) age
{
    return self->_age;
}

@end
