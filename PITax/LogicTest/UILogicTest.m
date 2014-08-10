//
//  UILogicTest.m
//  PITax
//
//  Created by cavernyu on 14-8-5.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ViewController.h"

@interface UILogicTest : XCTestCase
{
    id _textField;
    id _label;
    ViewController *_viewController;
}
@property (nonatomic,strong) id textField;
@property (nonatomic,strong) id label;
@property (nonatomic,strong) ViewController *viewController;

-(void)testCalculateOnClick;
@end

@implementation UILogicTest
@synthesize textField = _textField;
@synthesize label = _label;
@synthesize  viewController = _viewController;
- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.textField = [OCMockObject mockForClass:[UITextField class]];
    self.label = [OCMockObject mockForClass:[UILabel class]];
    self.viewController = [[ViewController alloc] init];
    
    [self.viewController setValue:self.textField forKey:@"textField"];
    [self.viewController setValue:self.label forKey:@"label"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [self.textField verify];
    [self.label verify];
    self.textField = nil;
    self.label = nil;
    self.viewController = nil;
    
    
    [super tearDown];
}

-(void)testCalculateOnClick
{
    [[[self.textField stub] andReturn:@"5000"] text];
    [[self.textField expect] resignFirstResponder];
    
    [[self.label expect] setText:@"月收入总额:45.000000"];
    [self.viewController onclick:OCMOCK_ANY];
}

@end
