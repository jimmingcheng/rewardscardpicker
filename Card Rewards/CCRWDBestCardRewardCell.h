//
//  CCRWDBestCardCardCell.h
//  Card Rewards
//
//  Created by Jimming Cheng on 11/27/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDReward;

@interface CCRWDBestCardRewardCell : UICollectionViewCell

@property (nonatomic) CCRWDReward *reward;

@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftArrow;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;

- (void)setHasMoreToLeft:(BOOL)hasMore;
- (void)setHasMoreToRight:(BOOL)hasMore;

@end
