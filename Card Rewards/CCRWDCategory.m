//
//  CCRWDCategory.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCategory.h"

@implementation CCRWDCategory

@dynamic categoryId;
@dynamic rewards;

- (id)initWithId:(NSString *)categoryId context:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self) {
        [self setCategoryId:categoryId];
        return self;
    }
    return nil;
}

+ (NSArray *)categoriesFromContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *categoriesRequest = [[NSFetchRequest alloc] initWithEntityName:@"Category"];
    return [[context executeFetchRequest:categoriesRequest error:nil] mutableCopy];
}

+ (NSArray *)updatedCategoriesFromJSON:(NSArray *)json context:(NSManagedObjectContext *)context
{
    NSMutableSet *newCategoryIds = [[NSMutableSet alloc] init];
    for (NSArray *cardJSON in json) {
        [newCategoryIds addObjectsFromArray:[cardJSON objectAtIndex:3]];
    }
    
    NSArray *existingCategories = [self categoriesFromContext:context];
    for (CCRWDCategory *category in existingCategories) {
        [context deleteObject:category];
    }
    
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    for (NSString *newCategoryId in newCategoryIds) {
        CCRWDCategory *category = [[CCRWDCategory alloc] initWithId:newCategoryId context:context];
        [categories addObject:category];
    }
    return categories;
}

@end
