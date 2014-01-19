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
#import "CCRWDBestCardRewardCell.h"
#import "CCRWDCardViewController.h"
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
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
    [self.myOrAllRewardsSelector setSelectedSegmentIndex:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_categoriesListView reloadData];
    [_magnifiedView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _categoriesListView || collectionView == _magnifiedView) {
        return _rewardsByCategoryId.allKeys.count;
    }
    else {
        CCRWDBestCardMagnifiedCell *magnifiedCell = (CCRWDBestCardMagnifiedCell *)collectionView.superview.superview;
        return [[_rewardsByCategoryId objectForKey:magnifiedCell.category.categoryId] count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _categoriesListView) {
        CCRWDCategory *category = [_categories objectAtIndex:indexPath.row];
        CCRWDBestCardCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
        [cell setCategory:category];
        return cell;
    }
    else if (collectionView == _magnifiedView) {
        CCRWDCategory *category = [_categories objectAtIndex:indexPath.row];
        CCRWDBestCardMagnifiedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MagnifiedCategoryCell" forIndexPath:indexPath];
        [cell setCategory:category rewards:[_rewardsByCategoryId objectForKey:category.categoryId]];
        return cell;
    }
    else {
        CCRWDBestCardMagnifiedCell *magnifiedCell = (CCRWDBestCardMagnifiedCell *)collectionView.superview.superview;
        CCRWDReward *reward = [[_rewardsByCategoryId objectForKey:magnifiedCell.category.categoryId] objectAtIndex:indexPath.row];
        CCRWDBestCardRewardCell *rewardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RewardCell" forIndexPath:indexPath];
        [rewardCell setReward:reward];
        return rewardCell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for(NSIndexPath *path in collectionView.indexPathsForSelectedItems) {
        if (path != indexPath) {
            [collectionView deselectItemAtIndexPath:path animated:NO];
        }
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (!_controlPanel.hidden) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anim.duration = 0.25;
        anim.fromValue = [NSNumber numberWithFloat:1.0];
        anim.toValue = [NSNumber numberWithFloat:0.0];
        [CATransaction setCompletionBlock:^{
            [_controlPanel setHidden:YES];
        }];
        [_controlPanel.layer addAnimation:anim forKey:@"opacity"];
        _controlPanel.layer.opacity = 0.0;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_categoriesListView.contentOffset.y == 0.0 && _controlPanel.hidden) {
        [_controlPanel setHidden:NO];
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anim.duration = 0.25;
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:1.0];
        [_controlPanel.layer addAnimation:anim forKey:@"opacity"];
        _controlPanel.layer.opacity = 1.0;
    }
}

- (void)setCards:(NSArray *)cards categories:(NSArray *)categories rewards:(NSArray *)rewards
{
    _cards = cards;
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
    
    _rewardsByCategoryId = [CCRWDReward rewardsByCategoryIdFromRewards:_rewards];
    
    NSLog(@"setCards");
}

- (IBAction)goBack:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Card"]) {
        UIButton *button = (UIButton *)sender;
        CCRWDBestCardRewardCell *cell = (CCRWDBestCardRewardCell *)button.superview.superview;
        CCRWDCardViewController *cardVC = (CCRWDCardViewController *)segue.destinationViewController;
        [cardVC setCard:cell.reward.creditCard];
    }
}

@end
