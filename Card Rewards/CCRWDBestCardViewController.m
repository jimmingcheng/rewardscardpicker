//
//  CCRWDBestCardViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 11/23/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDBestCardViewController.h"
#import "CCRWDBestCardCategoryCell.h"
#import "CCRWDBestCardMagnifiedCell.h"
#import "CCRWDCategory.h"
#import "CCRWDReward.h"

@interface CCRWDBestCardViewController ()

@end

@implementation CCRWDBestCardViewController

- (void)viewDidLoad
{
    CALayer *layer = _glassView.layer;
    layer.shadowOffset = CGSizeMake(0,0);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowRadius = 4.0f;
    layer.shadowOpacity = 0.80f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:CGRectMake(layer.bounds.origin.x - 10.0, layer.bounds.origin.y, layer.bounds.size.width + 20.0, layer.bounds.size.height)] CGPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cardsByCategoryId.allKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCRWDCategory *category = [_categories objectAtIndex:indexPath.row];
    if (collectionView == _categoriesListView) {
        CCRWDBestCardCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
        [cell setCategory:category];
        return cell;
    }
    else if (collectionView == _magnifiedView) {
        CCRWDBestCardMagnifiedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MagnifiedCategoryCell" forIndexPath:indexPath];
        [cell setCategory:category cards:[_cardsByCategoryId objectForKey:category.categoryId]];
        return cell;
    }
    else {
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for(NSIndexPath *path in collectionView.indexPathsForSelectedItems) {
        [collectionView deselectItemAtIndexPath:path animated:NO];
    }
    
    UICollectionViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    CGPoint offset = collectionView.contentOffset;
    offset.y = cell.layer.bounds.size.height * indexPath.row;
    [collectionView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _categoriesListView) {
        CGPoint offset = _categoriesListView.contentOffset;
        offset.y = offset.y * MAGNIFIED_CELL_HEIGHT/CATEGORY_CELL_HEIGHT;
        
        CGRect bounds = _magnifiedView.bounds;
        bounds.origin = offset;
        [_magnifiedView setBounds:bounds];
    }
    else if (scrollView == _magnifiedView) {
        CGPoint offset = _magnifiedView.contentOffset;
        offset.y = offset.y * CATEGORY_CELL_HEIGHT/MAGNIFIED_CELL_HEIGHT;
        CGRect bounds = _categoriesListView.bounds;
        bounds.origin = offset;
        [_categoriesListView setBounds:bounds];
    }
}

- (void)setCreditCards:(NSArray *)creditCards categories:(NSArray *)categories rewards:(NSArray *)rewards
{
    _creditCards = creditCards;
    _categories = [categories sortedArrayUsingComparator:^NSComparisonResult(CCRWDCategory *obj1, CCRWDCategory *obj2) {
        if ([obj1.categoryId isEqualToString:@"default_reward"]) {
            return NSOrderedAscending;
        }
        else if ([obj2.categoryId isEqualToString:@"default_reward"]) {
            return NSOrderedDescending;
        }
        else {
            return [obj1.categoryId compare:obj2.categoryId];
        }
    }];
    _rewards = rewards;
    
    _cardsByCategoryId = [CCRWDReward cardsByCategoryIdFromRewards:_rewards];
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    for (CCRWDBestCardCell *cell in _magnifiedView.visibleCells) {
//        [cell.nameLabel.layer setTransform:CATransform3DMakeScale(1.0, 1.0, 1.0)];
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    for (CCRWDBestCardCell *cell in _magnifiedView.visibleCells) {
//        
//        CAAnimationGroup *anim = [CAAnimationGroup animation];
//        [anim setAnimations:[NSArray arrayWithObjects:
//                             [CABasicAnimation animationWithKeyPath:@"transform"],
//                             [CABasicAnimation animationWithKeyPath:@"opacity"]
//                             , nil]];
//        [anim setDuration:0.25];
//        
//        //[self.layer addAnimation:anim forKey:nil];
//        //[self.layer setTransform:CATransform3DMakeScale(1.1, 1.1, 1.1)];
//        //[self.layer setOpacity:1.0];
//        
//        [cell.nameLabel.layer setTransform:CATransform3DMakeScale(1.0, 2.0, 1.0)];
//    }
//}


@end
