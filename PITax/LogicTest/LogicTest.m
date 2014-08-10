//
//  LogicTest.m
//  LogicTest
//
//  Created by cavernyu on 14-8-4.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface LogicTest : XCTestCase
@property(nonatomic, strong) ViewController *viewController;
@end

@implementation LogicTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewController = [[ViewController alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewController = nil;
    [super tearDown];
}

- (void)testCalculateLevel1
{
    NSString *strTax = [self.viewController calculate:[NSString stringWithFormat:@"%f", 5000.0f]];
    XCTAssertTrue([strTax doubleValue] == 45, @"期望值是45, 实际值是%@", strTax);

}

- (void)testCalculateLevel4
{
    NSString *strTax = [self.viewController calculate:[NSString stringWithFormat:@"%f", 38500.0f]];
    XCTAssertTrue([strTax doubleValue] == 7745, @"期望值是7745, 实际值是%@", strTax);
    
}

- (void)testCalculateLevel2
{
    NSString *strTax = [self.viewController calculate:[NSString stringWithFormat:@"%f", 8000.0f]];
    XCTAssertTrue([strTax doubleValue] == 345, @"期望值是345, 实际值是%@", strTax);
    
}

- (void)testCalculateLevel3
{
    NSString *strTax = [self.viewController calculate:[NSString stringWithFormat:@"%f", 12500.0f]];
    XCTAssertTrue([strTax doubleValue] == 1245, @"期望值是1245, 实际值是%@", strTax);
    
}

- (void)testCalculateLevel5
{
    NSString *strTax = [self.viewController calculate:[NSString stringWithFormat:@"%f", 58500.0f]];
    XCTAssertTrue([strTax doubleValue] == 13745, @"期望值是13745, 实际值是%@", strTax);
    
}

- (void)testCalculateLevel6
{
    NSString *strTax = [self.viewController calculate:[NSString stringWithFormat:@"%f", 83500.0f]];
    XCTAssertTrue([strTax doubleValue] == 22495, @"期望值是22495, 实际值是%@", strTax);
    
}

- (void)testCalculateLevel7
{
    NSString *strTax = [self.viewController calculate:[NSString stringWithFormat:@"%f", 103500.0f]];
    XCTAssertTrue([strTax doubleValue] == 31495, @"期望值是31495, 实际值是%@", strTax);
    
}


@end
