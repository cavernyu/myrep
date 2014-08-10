//
//  Send.m
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Send.h"

@implementation Send
@synthesize name = _name;
@synthesize info = _info;

-(void) sendNoticeLoop
{
   [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(sendNotice) userInfo:nil repeats:YES];
}

-(void) sendNotice
{
    NSNotificationCenter *noticeCen = [NSNotificationCenter defaultCenter];
    [noticeCen postNotificationName:[self name] object:self userInfo:[self info]];
}
@end
