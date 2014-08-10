//
//  Mother.m
//  hello
//
//  Created by cavernyu on 13-10-23.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "Mother.h"

@implementation Mother
@synthesize son = _son;
@synthesize keyPath = _keyPath;
-(void) registerObserver
{
    [self.son addObserver:self forKeyPath:self.keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath:%@ ofObject:%@ change:%@", keyPath, object, change);
}

-(void) unregisterObserver
{
    [self.son removeObserver:self forKeyPath:self.keyPath];
}


@end
