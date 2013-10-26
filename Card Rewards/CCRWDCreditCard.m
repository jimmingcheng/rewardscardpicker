//
//  CCRWDCreditCard.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCreditCard.h"
#import "CCRWDCategory.h"
#import "CCRWDReward.h"

@implementation CCRWDCreditCard

@dynamic cardId;
@dynamic rewards;
@dynamic owned;

- (id)initWithId:(NSString *)cardId context:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CreditCard" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self) {
        [self setCardId:cardId];
        return self;
    }
    return nil;
}

+ (NSManagedObject *)getCardWithId:(NSString *)cardId fromContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CreditCard"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cardId == %@", cardId];
    [request setPredicate:predicate];
    NSArray *cards = [[context executeFetchRequest:request error:nil] mutableCopy];
    if (cards.count == 1) {
        return [cards objectAtIndex:0];
    }
    else {
        return nil;
    }
}

+ (NSArray *)updateFromJSON:(NSArray *)json context:(NSManagedObjectContext *)context
{
    NSFetchRequest *cardsRequest = [[NSFetchRequest alloc] initWithEntityName:@"CreditCard"];
    NSArray *existingCards = [[context executeFetchRequest:cardsRequest error:nil] mutableCopy];
    
    NSMutableSet *newCardIds = [[NSMutableSet alloc] init];
    for (NSArray *cardJSON in json) {
        [newCardIds addObject:[cardJSON objectAtIndex:0]];
    }
    
    NSMutableSet *existingCardIds = [[NSMutableSet alloc] init];
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    for (CCRWDCreditCard *card in existingCards) {
        [existingCardIds addObject:card.cardId];
        if (![newCardIds containsObject:card.cardId]) {
            [context deleteObject:card];
        }
        else {
            [cards addObject:card];
        }
    }
    
    for (NSString *newCardId in newCardIds) {
        if (![existingCardIds containsObject:newCardId]) {
            CCRWDCreditCard *card = [[CCRWDCreditCard alloc] initWithId:newCardId context:context];
            [cards addObject:card];
        }
    }
    return cards;
}


@end
