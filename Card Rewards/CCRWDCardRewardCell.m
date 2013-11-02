//
//  CCRWDCategoryCell.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardRewardCell.h"

#import "CCRWDCreditCard.h"
#import "CCRWDReward.h"

@implementation CCRWDCardRewardCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setCard:(CCRWDCreditCard *)card
{
    _card = card;
    _nameLabel.text = _card.name;
    _cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _card.cardId]];
    [_toggleStarButton setSelected:[_card.starred boolValue]];
}

- (void)setReward:(CCRWDReward *)reward
{
    _reward = reward;
    _rewardLabel.text = [NSString stringWithFormat:@"%@%@", reward.amount, reward.unit];
}

- (IBAction)toggleStar:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setSelected:![button isSelected]];
    
    [_card setStarred:[NSNumber numberWithBool:[button isSelected]]];
}

@end
