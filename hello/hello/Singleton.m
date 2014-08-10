//
//  Singleton.m
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Singleton.h"

static id singleton;
@implementation Singleton
@synthesize name = _name;

+ (id) sharedInstance
{
//    @synchronized(self){
//        if(singleton == nil)
//        {
//            singleton = [[[self class] alloc] init];
//        }
//    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
    });
    
    //免锁写法
//    static BOOL initialized = NO;
//    if(!initialized)
//    {
//        singleton = [[[self class] alloc] init];
//        initialized = YES;
//    }
    return singleton;
}
@end
