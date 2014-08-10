//
//  MyGHTest.m
//  PITax
//
//  Created by cavernyu on 14-8-5.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

@interface MyGHTest : GHTestCase

@end

@implementation MyGHTest

-(void)setUp
{
    
}

-(void)tearDown
{
    
}

-(void)setUpClass
{
    
}

-(void)tearDownClass
{
    
}

-(void)testEqualStrings
{
    GHTestLog(@"比较两个字符串是否相等:");
    NSString *str1 = @"abc";
    GHAssertNotNil(str1, nil);
    NSString *str2 = @"ABC";
    GHAssertEqualObjects(str1, str2, @"STR1应该等于%@", str2);
}

@end
