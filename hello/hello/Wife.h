//
//  Wife.h
//  hello
//
//  Created by cavernyu on 13-10-22.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wife : NSObject
{
    NSString *_name;
    void (^callBackToHusband) (void);
}

@property NSString *name;
-(void) beAskedBuyFood:(void (^) (void)) _callBackToHusband;

@end
