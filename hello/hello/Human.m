//
//  Human.m
//  hello
//
//  Created by cavernyu on 13-10-27.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Human.h"

@implementation Human
@synthesize name = _name;
@synthesize age = _age;
-(id) initWithCoder:(NSCoder *)aDecoder
{
   self.age = [aDecoder decodeIntegerForKey:@"age"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end
