//
//  Husband.h
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wife.h"

@interface Husband : NSObject
{
    NSString *_name;
    Wife *_wife;
}

@property NSString *name;
@property Wife *wife;

- (void) askWifeBuyFood;

@end
