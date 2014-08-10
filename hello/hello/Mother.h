//
//  Mother.h
//  hello
//
//  Created by cavernyu on 13-10-23.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Son.h"

@interface Mother : NSObject
{
    NSString *_keyPath;
    Son *_son;
}
@property Son *son;
@property NSString *keyPath;

-(void) registerObserver;

-(void) unregisterObserver;

@end
