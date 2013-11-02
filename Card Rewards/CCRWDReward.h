//
//  CCRWDReward.h
//  Card Rewards
//
//  Created by Jimming Cheng on 10/24/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CCRWDCreditCard;

@interface CCRWDReward : NSManagedObject

@property (nonatomic) NSNumber *amount;
@property (nonatomic) NSString *unit;
@property (nonatomic) CCRWDCreditCard *creditCard;
@property (nonatomic) NSSet *categories;

- (id)initWithAmount:(NSNumber *)amount unit:(NSString *)unit context:(NSManagedObjectContext *)context;
+ (NSArray *)rewardsFromContext:(NSManagedObjectContext *)context;
+ (NSArray *)updatedRewardsFromJSON:(NSArray *)json creditCards:(NSArray *)creditCards categories:(NSArray *)categories toContext:(NSManagedObjectContext *)context;
+ (NSDictionary *)cardsByCategoryIdFromRewards:(NSArray *)rewards;

@end
