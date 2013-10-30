//
//  CCRWDCardCell.m
//  Card Rewards
//
//  Created by Jimming Cheng on 10/28/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardCell.h"

#import "CCRWDCreditCard.h"

@implementation CCRWDCardCell

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
    _nameLabel.text = _card.cardId;
}

@end
