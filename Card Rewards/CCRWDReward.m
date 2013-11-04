//
//  CCRWDReward.m
//  Card Rewards
//
//  Created by Jimming Cheng on 10/24/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCreditCard.h"
#import "CCRWDCategory.h"
#import "CCRWDReward.h"

@implementation CCRWDReward

@dynamic amount;
@dynamic unit;
@dynamic creditCard;
@dynamic categories;

- (id)initWithAmount:(NSNumber *)amount unit:(NSString *)unit context:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Reward" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self) {
        [self setAmount:amount];
        [self setUnit:unit];
        return self;
    }
    return nil;
}

+ (NSArray *)rewardsFromContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *rewardsRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reward"];
    return [context executeFetchRequest:rewardsRequest error:nil];
}

+ (NSArray *)updatedRewardsFromJSON:(NSArray *)json creditCards:(NSArray *)creditCards categories:(NSArray *)categories toContext:(NSManagedObjectContext *)context
{
    
    NSMutableDictionary *cardsById = [[NSMutableDictionary alloc] init];
    for (CCRWDCreditCard *card in creditCards) {
        [cardsById setObject:card forKey:card.cardId];
    }
    
    NSMutableDictionary *categoriesById = [[NSMutableDictionary alloc] init];
    for (CCRWDCategory *category in categories) {
        [categoriesById setObject:category forKey:category.categoryId];
    }
    
    NSArray *existingRewards = [self rewardsFromContext:context];
    for (CCRWDReward *reward in existingRewards) {
        [context deleteObject:reward];
    }
    
    NSMutableArray *rewards = [[NSMutableArray alloc] init];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    for (NSArray *cardJSON in json) {
        NSString *cardId = [cardJSON objectAtIndex:0];
        NSArray *categoryIds = [cardJSON objectAtIndex:3];
        NSNumber *rewardAmount = [formatter numberFromString:[cardJSON objectAtIndex:4]];
        NSString *rewardUnit = [cardJSON objectAtIndex: 5];
        
        NSMutableSet *categoriesForCard = [[NSMutableSet alloc] init];
        for (NSString *categoryId in categoryIds) {
            [categoriesForCard addObject:[categoriesById objectForKey:categoryId]];
        }
        
        CCRWDReward *reward = [[CCRWDReward alloc] initWithAmount:rewardAmount unit:rewardUnit context:context];
        [reward setCreditCard:[cardsById objectForKey:cardId]];
        [reward setCategories:categoriesForCard];
        [rewards addObject:reward];
    }
    return rewards;
}

+ (NSDictionary *)cardsByCategoryIdFromRewards:(NSArray *)rewards
{
    NSMutableDictionary *rewardsByCategoryId = [[NSMutableDictionary alloc] init];
    for (CCRWDReward *reward in rewards) {
        for (CCRWDCategory *category in reward.categories) {
            NSMutableArray *rewards = [rewardsByCategoryId objectForKey:category.categoryId];
            if (rewards == nil) {
                rewards = [[NSMutableArray alloc] init];
                [rewardsByCategoryId setValue:rewards forKey:category.categoryId];
            }
            [rewards addObject:reward];
        }
    }
    
    NSMutableDictionary *cardsByCategoryId = [[NSMutableDictionary alloc] init];
    for (NSString *categoryId in rewardsByCategoryId) {
        NSMutableArray *rewards = [rewardsByCategoryId objectForKey:categoryId];
        [rewards sortUsingComparator:^NSComparisonResult(CCRWDReward *obj1, CCRWDReward *obj2) {
            return [obj2.amount compare:obj1.amount];
        }];
        NSMutableArray *cards = [[NSMutableArray alloc] init];
        for (CCRWDReward *reward in rewards) {
            [cards addObject:reward.creditCard];
        }
        [cardsByCategoryId setObject:cards forKey:categoryId];
    }

    return cardsByCategoryId;
}

@end
