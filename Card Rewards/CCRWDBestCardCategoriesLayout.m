//
//  CCRWDBestCardsCategoriesListLayout.m
//  Card Rewards
//
//  Created by Jimming Cheng on 11/24/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDBestCardCategoriesLayout.h"
#import "CCRWDBestCardViewController.h"

@implementation CCRWDBestCardCategoriesLayout

- (void)prepareLayout
{
    [self setItemSize:CGSizeMake(320.0, CATEGORY_CELL_HEIGHT)];
    [self setMinimumLineSpacing:0.0];
    CGFloat height = (self.collectionView.bounds.size.height - MAGNIFIED_CELL_HEIGHT)/2.0;
    [self setHeaderReferenceSize:CGSizeMake(320.0, height)];
    [self setFooterReferenceSize:CGSizeMake(320.0, height + MAGNIFIED_CELL_HEIGHT - CATEGORY_CELL_HEIGHT)];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in array) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell &&
            attributes.frame.origin.y > self.collectionView.contentOffset.y + self.headerReferenceSize.height) {
            CGPoint newCenter = attributes.center;
            newCenter.y += MAGNIFIED_CELL_HEIGHT - CATEGORY_CELL_HEIGHT;
            [attributes setCenter:newCenter];
        }
    }
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGPoint target = proposedContentOffset;
    target.y = round(target.y / CATEGORY_CELL_HEIGHT) * CATEGORY_CELL_HEIGHT;
    return target;
}

@end
