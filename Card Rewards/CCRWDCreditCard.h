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
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *notes;
@property (nonatomic) NSSet *rewards;
@property (nonatomic) NSNumber *starred;

- (id)initWithId:(NSString *)cardId name:(NSString *)name notes:(NSString *)notes context:(NSManagedObjectContext *)context;
+ (NSArray *)cardsFromContext:(NSManagedObjectContext *)context;
+ (NSArray *)updatedCardsFromJSON:(NSArray *)json context:(NSManagedObjectContext *)context;
+ (NSArray *)searchCardsWithWords:(NSString *)searchString context:(NSManagedObjectContext *)context;

@end
