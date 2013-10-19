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
@property (nonatomic, copy) NSString *reward;

- (id)initWithName:(NSString *)name categories:(NSArray *)categories reward:(NSString *)reward;

+ (NSArray *)creditCardsFromJSON:(NSArray *)json;

+ (NSDictionary *)creditCardsByCategory:(NSArray *)cards;

@end
