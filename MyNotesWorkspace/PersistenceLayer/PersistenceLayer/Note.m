//
//  Note.m
//  PersistenceLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "Note.h"

@implementation Note

@synthesize title = _title;

@synthesize content = _content;

@synthesize date = _date;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self.title = (NSString*)[aDecoder decodeObjectForKey:@"title"];
    self.content = (NSString*)[aDecoder decodeObjectForKey:@"content"];
    self.date = (NSDate*)[aDecoder decodeObjectForKey:@"date"];

    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    
    [aCoder encodeObject:self.content forKey:@"content"];
    
    [aCoder encodeObject:self.date forKey:@"date"];
}
@end
