//
//  CCRWDCreditCard.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCRWDCreditCard : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *categories;

- (id)initWithName:(NSString *)name categories:(NSArray *)categories;

+ (NSArray *)creditCardsFromJSON:(NSArray *)json;

+ (NSDictionary *)creditCardsByCategory:(NSArray *)cards;

@end
