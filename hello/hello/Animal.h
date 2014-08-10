//
//  Animal.h
//  hello
//
//  Created by cavernyu on 13-10-18.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject
{
@private
    NSString *_name;
    int _age;
}


- (void) setName:(NSString *) name;

- (NSString *) name;

- (void) run;

@end
