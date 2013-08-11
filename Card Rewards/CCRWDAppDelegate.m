//
//  CCRWDAppDelegate.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDAppDelegate.h"
#import "CCRWDCardsViewController.h"
#import "CCRWDCategoriesViewController.h"

@implementation CCRWDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:@"http://cccal.herokuapp.com/api/0/"]];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    
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

- (void)fetchedData:(NSData *)responseData {
    NSString *strData = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];

    NSLog(@"%@", strData);
    
    NSError * error;
    NSArray * json = [NSJSONSerialization
                      JSONObjectWithData:responseData
                      options:kNilOptions
                      error:&error];

    UITabBarController * rootViewController = (UITabBarController *)self.window.rootViewController;
    for (id vc in rootViewController.viewControllers) {
        if ([vc respondsToSelector:@selector(loadData:)]) {
            [vc loadData:json];
        }
    }
}

@end
