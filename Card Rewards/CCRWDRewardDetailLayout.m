//
//  CCRWDRewardDetailLayout.m
//  Card Rewards
//
//  Created by Jimming Cheng on 11/3/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDRewardDetailLayout.h"

@implementation CCRWDRewardDetailLayout

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setItemSize:CGSizeMake(240, 43)];
    }
    
    return self;
}

- (CGSize)collectionViewContentSize
{
    CGFloat h = [self.collectionView numberOfItemsInSection:0] * (self.itemSize.height + self.minimumLineSpacing);
    
    for (NSLayoutConstraint *constraint in self.collectionView.constraints) {
        if (constraint.firstItem == self.collectionView && constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = h;
        }
    }

    return CGSizeMake(self.itemSize.width, h);
}

@end
