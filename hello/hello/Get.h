//
//  Get.h
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Get : NSObject
{
    NSString *_name;
}
@property (nonatomic,retain) NSString *name;

-(void) notice:(NSNotification *) notice;

-(void) getNotice;

@end
