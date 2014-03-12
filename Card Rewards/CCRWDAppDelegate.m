//
//  CCRWDAppDelegate.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDAppDelegate.h"
#import "CCRWDBestCardViewController.h"
#import "CCRWDCreditCard.h"
#import "CCRWDCategory.h"
#import "CCRWDReward.h"
#import "Reachability.h"

@implementation CCRWDAppDelegate
{
    NSArray *_creditCards;
    NSArray *_categories;
    NSArray *_rewards;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"viewStates" ofType:@"plist"];
    _viewStatesPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

    [self initCardsAndRewardsData];
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        [self fetchCardsAndRewardsData];
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
    [self saveContext];
    
    NSString *error;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"viewStates" ofType:@"plist"];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.viewStatesPlist
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    [plistData writeToFile:plistPath atomically:YES];
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
    [self saveContext];
    
    NSString *error;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"viewStates" ofType:@"plist"];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.viewStatesPlist
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    [plistData writeToFile:plistPath atomically:YES];
}

- (void)initCardsAndRewardsData
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    UINavigationController *rootVC = (UINavigationController *)self.window.rootViewController;
    CCRWDBestCardViewController *bestCardVC = (CCRWDBestCardViewController *)[rootVC.viewControllers objectAtIndex:0];

    [bestCardVC setCards:[CCRWDCreditCard cardsFromContext:context]
                    categories:[CCRWDCategory categoriesFromContext:context]
                       rewards:[CCRWDReward rewardsFromContext:context]];
}

- (void)fetchCardsAndRewardsData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:@"http://cccal.herokuapp.com/api/0/cards/"]];
        [self performSelectorOnMainThread:@selector(fetchedCardsData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedCardsData:(NSData *)responseData {
    NSString *strData = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", strData);
    
    NSError * error;
    NSArray * json = [NSJSONSerialization
                      JSONObjectWithData:responseData
                      options:kNilOptions
                      error:&error];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    _creditCards = [CCRWDCreditCard updatedCardsFromJSON:json context:context];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:@"http://cccal.herokuapp.com/api/0/rewards/"]];
        [self performSelectorOnMainThread:@selector(fetchedRewardsData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedRewardsData:(NSData *)responseData {
    NSString *strData = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];

    //NSLog(@"%@", strData);
    
    NSError * error;
    NSArray * json = [NSJSONSerialization
                      JSONObjectWithData:responseData
                      options:kNilOptions
                      error:&error];
    
    UINavigationController *rootVC = (UINavigationController *)self.window.rootViewController;
    CCRWDBestCardViewController *bestCardVC = (CCRWDBestCardViewController *)[rootVC.viewControllers objectAtIndex:0];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    _categories = [CCRWDCategory updatedCategoriesFromJSON:json context:context];
    _rewards = [CCRWDReward updatedRewardsFromJSON:json creditCards:_creditCards categories:_categories toContext:context];
    
    [bestCardVC setCards:_creditCards categories:_categories rewards:_rewards];
    
    [context save:nil];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Card_Rewards" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Card_Rewards.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
