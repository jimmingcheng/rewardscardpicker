//
//  CCRWDCategory.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCategory.h"

@implementation CCRWDCategory

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        return self;
    }
    return nil;
}

+ (NSArray *)loadAllCategories
{
    NSMutableArray * cards = [[NSMutableArray alloc] init];
    
    [cards addObject: [[CCRWDCategory alloc] initWithName:@"category0"]];
    [cards addObject: [[CCRWDCategory alloc] initWithName:@"category1"]];
    [cards addObject: [[CCRWDCategory alloc] initWithName:@"category2"]];
    [cards addObject: [[CCRWDCategory alloc] initWithName:@"category3"]];
    [cards addObject: [[CCRWDCategory alloc] initWithName:@"category4"]];
    [cards addObject: [[CCRWDCategory alloc] initWithName:@"category5"]];
    
    return cards;
}

@end
