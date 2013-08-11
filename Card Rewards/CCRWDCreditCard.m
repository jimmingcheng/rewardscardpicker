//
//  CCRWDCreditCard.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCreditCard.h"

@implementation CCRWDCreditCard

- (id)initWithName:(NSString *)name categories:(NSArray *)categories
{
    self = [super init];
    if (self) {
        _name = name;
        _categories = categories;
        return self;
    }
    return nil;
}

+ (NSArray *)creditCardsFromJSON:(NSArray *)json
{
    NSMutableArray * cards = [[NSMutableArray alloc] init];
    for (NSArray * cardJSON in json) {
        NSString * name = [cardJSON objectAtIndex:0];
        NSArray * categories = [cardJSON objectAtIndex:2];
        [cards addObject: [[CCRWDCreditCard alloc] initWithName:name categories:categories]];
    }
    return cards;
}

+ (NSDictionary *)creditCardsByCategory:(NSArray *)cards
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    for (CCRWDCreditCard * card in cards) {
        for (NSString * category in card.categories) {
            NSMutableArray * cardsWithCategory = [dict objectForKey:category];
            if (!cardsWithCategory) {
                cardsWithCategory = [[NSMutableArray alloc] init];
                [dict setObject:cardsWithCategory forKey:category];
            }
            [cardsWithCategory addObject:card];
        }
    }
    return dict;
}

@end
