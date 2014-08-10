//
//  Send.h
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Send : NSObject
{
    NSString *_name;
    NSDictionary *_info;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDictionary *info;

-(void) sendNoticeLoop;
-(void) sendNotice;
@end
