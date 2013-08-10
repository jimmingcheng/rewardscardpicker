//
//  CCRWDCreditCard.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCreditCard.h"

@implementation CCRWDCreditCard

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        return self;
    }
    return nil;
}

+ (NSArray *)loadAllCreditCards
{
    NSMutableArray * cards = [[NSMutableArray alloc] init];
    
    [cards addObject: [[CCRWDCreditCard alloc] initWithName:@"card0"]];
    [cards addObject: [[CCRWDCreditCard alloc] initWithName:@"card1"]];
    [cards addObject: [[CCRWDCreditCard alloc] initWithName:@"card2"]];
    [cards addObject: [[CCRWDCreditCard alloc] initWithName:@"card3"]];
    [cards addObject: [[CCRWDCreditCard alloc] initWithName:@"card4"]];
    
    return cards;
}

@end
