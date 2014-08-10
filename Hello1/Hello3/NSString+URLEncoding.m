//
//  NSString+URLEncoding.m
//  Hello1
//
//  Created by cavernyu on 13-11-5.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

-(NSString *)URLEncodingString{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL,CFSTR("!*'();:@&AMP;=+$,/?%#[] "), kCFStringEncodingUTF8);
    return result;
}

-(NSString *)URLDecodedString{
    NSString * result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    return result;
}

@end
