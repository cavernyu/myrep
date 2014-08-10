//
//  AppDelegate.h
//  TabNavigationNib
//
//  Created by cavernyu on 13-12-3.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeiViewController.h"
#import "JiViewController.h"
#import "LiaoViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
