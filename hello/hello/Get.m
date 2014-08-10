//
//  Get.m
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Get.h"

@implementation Get
@synthesize name = _name;
-(void) notice:(NSNotification *)notice
{
    NSLog(@"%@", [notice userInfo]);
}

-(void) getNotice
{
    NSNotificationCenter *noticeCen = [NSNotificationCenter defaultCenter];
    [noticeCen addObserver:self selector:@selector(notice:) name:[self name] object:nil];
    
}
@end
