//
//  CCRWDBestCardCardCell.m
//  Card Rewards
//
//  Created by Jimming Cheng on 11/27/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDBestCardRewardCell.h"
#import "CCRWDCreditCard.h"
#import "CCRWDReward.h"

@implementation CCRWDBestCardRewardCell

- (void)setReward:(CCRWDReward *)reward
{
    _reward = reward;
    [_cardButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _reward.creditCard.cardId]] forState:UIControlStateNormal];

    if ([_reward.unit isEqualToString:@"cash back"]) {
        [_rewardLabel setText:[NSString stringWithFormat:@"%@%% %@", _reward.amount, _reward.unit]];
    }
    else {
        [_rewardLabel setText:[NSString stringWithFormat:@"%@x %@", _reward.amount, _reward.unit]];
    }
}

- (void)setHasMoreToLeft:(BOOL)hasMore
{
    if (hasMore) {
        [_leftArrow setHidden:NO];
    }
    else {
        [_leftArrow setHidden:YES];
    }
}

- (void)setHasMoreToRight:(BOOL)hasMore
{
    if (hasMore) {
        [_rightArrow setHidden:NO];
    }
    else {
        [_rightArrow setHidden:YES];
    }
}

@end
