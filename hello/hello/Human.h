//
//  Human.h
//  hello
//
//  Created by cavernyu on 13-10-27.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Human : NSObject <NSCoding>
{
    NSString *_name;
    NSUInteger _age;
}
@property NSUInteger age;
@property NSString *name;

@end
