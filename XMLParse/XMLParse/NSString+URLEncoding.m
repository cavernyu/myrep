//
//  NSString+URLEncoding.m
//  XMLParse
//
//  Created by cavernyu on 14-6-1.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

-(NSString *)URLEncodingString
{
    return (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("+$,#[] "), kCFStringEncodingUTF8);
}

-(NSString *)URLDecodingString
{
    return (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
}

@end
