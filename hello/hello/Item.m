//
//  Item.m
//  hello
//
//  Created by cavernyu on 13-10-23.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Item.h"

@implementation Item
@synthesize itemName = _itemName;
@synthesize itemID = _itemID;
@synthesize score = _score;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"设置UndefinedKey%@ 值%@", key, value);
}

-(id) valueForUndefinedKey:(NSString *)key
{
    NSLog(@"获得UndefinedKey%@的值", key);
    return @"描述";
}

@end
