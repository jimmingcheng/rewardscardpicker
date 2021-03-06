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
@dynamic name;
@dynamic notes;
@dynamic rewards;
@dynamic starred;

- (id)initWithId:(NSString *)cardId name:(NSString *)name notes:(NSString *)notes context:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CreditCard" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self) {
        [self setCardId:cardId];
        [self setName:name];
        [self setNotes:notes];
        return self;
    }
    return nil;
}

+ (NSArray *)cardsFromContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *cardsRequest = [[NSFetchRequest alloc] initWithEntityName:@"CreditCard"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    [cardsRequest setSortDescriptors:@[sortDescriptor]];
    
    return [context executeFetchRequest:cardsRequest error:nil];
}

+ (NSArray *)updatedCardsFromJSON:(NSArray *)json context:(NSManagedObjectContext *)context
{
    NSArray *existingCards = [self cardsFromContext:context];
    
    NSMutableSet *newCardIds = [[NSMutableSet alloc] init];
    NSMutableDictionary *newCardNames = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *newCardNotes = [[NSMutableDictionary alloc] init];
    for (NSArray *cardJSON in json) {
        NSString *cardId = [cardJSON objectAtIndex:0];
        [newCardIds addObject:cardId];
        [newCardNames setObject:[cardJSON objectAtIndex:1] forKey:cardId];
        [newCardNotes setObject:[cardJSON objectAtIndex:2] forKey:cardId];
    }
    
    NSMutableSet *existingCardIds = [[NSMutableSet alloc] init];
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    for (CCRWDCreditCard *card in existingCards) {
        [existingCardIds addObject:card.cardId];
        if (![newCardIds containsObject:card.cardId]) {
            [context deleteObject:card];
        }
        else {
            [card setName:[newCardNames objectForKey:card.cardId]];
            [card setNotes:[newCardNotes objectForKey:card.cardId]];
            [cards addObject:card];
        }
    }
    
    for (NSString *newCardId in newCardIds) {
        if (![existingCardIds containsObject:newCardId]) {
            NSString *name = [newCardNames objectForKey:newCardId];
            NSString *notes = [newCardNotes objectForKey:newCardId];
            CCRWDCreditCard *card = [[CCRWDCreditCard alloc] initWithId:newCardId name:name notes:notes context:context];
            [cards addObject:card];
        }
    }
    
    [cards sortUsingComparator:^NSComparisonResult(CCRWDCreditCard *obj1, CCRWDCreditCard *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    
    return cards;
}

+ (NSArray *)searchCardsWithWords:(NSString *)searchString context:(NSManagedObjectContext *)context
{
    NSFetchRequest *cardsRequest = [[NSFetchRequest alloc] initWithEntityName:@"CreditCard"];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchString];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    
    [cardsRequest setPredicate:predicate];
    [cardsRequest setSortDescriptors:@[sortDescriptor]];
    
    return [context executeFetchRequest:cardsRequest error:nil];
}


@end
