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
}
@end
