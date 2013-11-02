//
//  Card_RewardsTests.m
//  Card RewardsTests
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CCRWDCreditCard.h"
#import "CCRWDCategory.h"
#import "CCRWDReward.h"

@interface Card_RewardsTests : XCTestCase

@end

@implementation Card_RewardsTests
{
    NSManagedObjectContext *_managedObjectContext;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _managedObjectContext = [self managedObjectContext];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadCreditCardFromJSON
{
    NSArray *json = [self parseJSON:
                     @"[[\"chase_freedom\", [], [\"gas\", \"groceries\", \"restaurants\"], \"5\", \"%\"]]"
                     ];
    NSArray *creditCards = [CCRWDCreditCard updatedCardsFromJSON:json context:_managedObjectContext];
    NSArray *categories = [CCRWDCategory updatedCategoriesFromJSON:json context:_managedObjectContext];
    NSArray *rewards = [CCRWDReward updatedRewardsFromJSON:json creditCards:creditCards categories:categories toContext:_managedObjectContext];
    
    [_managedObjectContext save:nil];
    
    CCRWDCreditCard *card = [creditCards objectAtIndex:0];
    CCRWDReward *reward = [rewards objectAtIndex:0];
    XCTAssertEqualObjects(card.cardId, @"chase_freedom", @"Should have correct cardId");
    XCTAssertTrue([card.rewards containsObject:reward], @"Card should be linked to reward");
}

- (void)testLoadRewardFromJSON
{
    NSArray *json = [self parseJSON:
                     @"[[\"chase_freedom\", [], [\"gas\", \"groceries\", \"restaurants\"], \"5\", \"%\"]]"
                     ];
    NSArray *creditCards = [CCRWDCreditCard updatedCardsFromJSON:json context:_managedObjectContext];
    NSArray *categories = [CCRWDCategory updatedCategoriesFromJSON:json context:_managedObjectContext];
    NSArray *rewards = [CCRWDReward updatedRewardsFromJSON:json creditCards:creditCards categories:categories toContext:_managedObjectContext];

    [_managedObjectContext save:nil];
    
    CCRWDReward *reward = [rewards objectAtIndex:0];
    XCTAssertEqual(reward.categories.count, 3u, @"Should have correct number of categories");
    XCTAssertEqual([reward.amount doubleValue], 5.0, @"Should have correct amount");
    XCTAssertEqualObjects(reward.unit, @"%", @"Should have correct unit");
}

- (void)testLoadMultipleCardsFromJSON
{
    NSArray *json = [self parseJSON:
                     @"[[\"chase_freedom\", [], [\"gas\", \"groceries\", \"restaurants\"], \"5\", \"%\"],"
                      "[\"citi_forward\", [], [\"amazon\", \"music_stores\", \"restaurants\"], \"5\", \"%\"]]"
                     ];
    
    NSArray *creditCards = [CCRWDCreditCard updatedCardsFromJSON:json context:_managedObjectContext];
    NSArray *categories = [CCRWDCategory updatedCategoriesFromJSON:json context:_managedObjectContext];
    NSArray *rewards = [CCRWDReward updatedRewardsFromJSON:json creditCards:creditCards categories:categories toContext:_managedObjectContext];
    
    XCTAssertEqual([creditCards count], 2u, @"Should have correct number of credit cards");
    XCTAssertEqual([categories count], 5u, @"Should have correct number of categories");
    XCTAssertEqual([rewards count], 2u, @"Should have correct number of rewards");
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSArray *)parseJSON:(NSString *)jsonStr
{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
}

@end
