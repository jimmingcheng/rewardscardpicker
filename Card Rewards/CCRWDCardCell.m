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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor] );
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokePath(context);
}

- (void)setCard:(CCRWDCreditCard *)card
{
    _card = card;
    _nameLabel.text = _card.name;
    _cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _card.cardId]];
    [_toggleStarButton setSelected:[_card.starred boolValue]];
}

- (IBAction)toggleStar:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setSelected:![button isSelected]];
    
    [_card setStarred:[NSNumber numberWithBool:[button isSelected]]];
}

@end
