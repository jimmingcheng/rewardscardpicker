//
//  CCRWDCardSearchResultCell.m
//  Card Rewards
//
//  Created by Jimming Cheng on 1/25/14.
//  Copyright (c) 2014 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardSearchResultCell.h"
#import "CCRWDCreditCard.h"

@implementation CCRWDCardSearchResultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCard:(CCRWDCreditCard *)card
{
    _card = card;
    [_nameLabel setText:_card.name];
}


@end
