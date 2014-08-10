//
//  AppDelegate.m
//  PresentationLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Settings" ofType:@"bundle"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[path stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *array = [dict objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithCapacity:[array count]];
    
    for(NSDictionary *perDict in array){
        NSString *key = [perDict objectForKey:@"Key"];
        if(key){
            [mutableDict setObject:[perDict objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    [userDefaults registerDefaults:mutableDict];
    

//    NSArray *languageIDs = [NSLocale availableLocaleIdentifiers];
//    for(id language in languageIDs){
//        NSLog(@"%@", language);
//    }
    
//    NSLog(@"%@", [[NSLocale preferredLanguages] objectAtIndex:0]);
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        UISplitViewController *splitViewController =  (UISplitViewController *)[self.window rootViewController];
        splitViewController.delegate = (id)[[splitViewController.viewControllers lastObject] topViewController];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
