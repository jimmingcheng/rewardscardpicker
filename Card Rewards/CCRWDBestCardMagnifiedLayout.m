//
//  CCRWDBestCardMagnifiedLayout.m
//  Card Rewards
//
//  Created by Jimming Cheng on 11/24/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDBestCardMagnifiedLayout.h"
#import "CCRWDBestCardViewController.h"

@implementation CCRWDBestCardMagnifiedLayout

- (void)prepareLayout
{
    [self setItemSize:CGSizeMake(320.0, MAGNIFIED_CELL_HEIGHT)];
    [self setMinimumLineSpacing:0.0];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGPoint target = proposedContentOffset;
    target.y = round(target.y / MAGNIFIED_CELL_HEIGHT) * MAGNIFIED_CELL_HEIGHT;
    return target;
}

@end
