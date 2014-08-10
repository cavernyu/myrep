//
//  PITaxTests.m
//  PITaxTests
//
//  Created by cavernyu on 14-8-4.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "ViewController.h"
@interface PITaxTests : XCTestCase
@property (nonatomic, strong) ViewController *viewController;
@end

@implementation PITaxTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = [appDelegate window];
    self.viewController = (ViewController*)window.rootViewController;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewController = nil;
    [super tearDown];
}

- (void)testOnclickInputBlank
{
    XCTAssertNotNil(self.viewController, @"ViewController没有赋值");
    self.viewController.textField.text = nil;
    [self.viewController onclick:nil];
    NSString *strTax = self.viewController.label.text;
    XCTAssertEqualObjects(strTax, @"月收入总额:0.00", @"期望值是0.00 实际值是%@", strTax);
}

- (void)testOnclickInputIntegerNumber
{
    XCTAssertNotNil(self.viewController, @"ViewController没有赋值");
    self.viewController.textField.text = @"8000";
    [self.viewController onclick:nil];
    NSString *strTax = self.viewController.label.text;
    XCTAssertEqualObjects(strTax, @"月收入总额:345.00", @"期望值是345.00 实际值是%@", strTax);
}

@end
