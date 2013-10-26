//
//  CCRWDCreditCard.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCRWDCreditCard : NSManagedObject

@property (nonatomic) NSString *cardId;
@property (nonatomic) NSSet *rewards;
@property (nonatomic) NSNumber *owned;

- (id)initWithId:(NSString *)cardId context:(NSManagedObjectContext *)context;
+ (NSArray *)updateFromJSON:(NSArray *)json context:(NSManagedObjectContext *)context;

@end
