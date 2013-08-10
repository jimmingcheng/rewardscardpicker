//
//  CCRWDCreditCard.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCRWDCreditCard : NSObject

@property (nonatomic, copy) NSString * name;

- (id)initWithName:(NSString *)name;

+ (NSArray *)loadAllCreditCards;

@end
