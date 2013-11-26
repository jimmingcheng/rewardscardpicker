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
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextSetLineWidth(context, 50.0);
    
    CGContextMoveToPoint(context, minX, minY);
    CGContextAddLineToPoint(context, minX, maxY);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, maxX, minY);
    CGContextAddLineToPoint(context, maxX, maxY);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, minX, maxY);
    CGContextAddLineToPoint(context, maxX, maxY);
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
