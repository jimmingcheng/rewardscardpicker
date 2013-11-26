//
//  CCRWDBestCardCell.m
//  Card Rewards
//
//  Created by Jimming Cheng on 11/24/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDBestCardMagnifiedCell.h"
#import "CCRWDCreditCard.h"
#import "CCRWDCategory.h"

@implementation CCRWDBestCardMagnifiedCell

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor] );
    CGContextSetLineWidth(context, 40.0);
    CGContextStrokePath(context);
}

- (void)setCategory:(CCRWDCategory *)category cards:(NSArray *)cards
{
    _category = category;
    _cards = cards;
    
    CCRWDCreditCard *bestCard = [_cards objectAtIndex:0];
    
    [_categoryLabel setText:_category.name];
    [_cardImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", bestCard.cardId]]];
}
@end
