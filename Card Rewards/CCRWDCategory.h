//
//  CCRWDCategory.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCRWDCategory : NSManagedObject

@property (nonatomic) NSString * categoryId;
@property (nonatomic) NSArray * rewards;

- (id)initWithId:(NSString *)categoryId context:(NSManagedObjectContext *)context;
+ (NSArray *)categoriesFromContext:(NSManagedObjectContext *)context;
+ (NSArray *)updatedCategoriesFromJSON:(NSArray *)json context:(NSManagedObjectContext *)context;

@end
