//
//  CCRWDBestCardCategoryCell.m
//  Card Rewards
//
//  Created by Jimming Cheng on 11/25/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDBestCardCategoryCell.h"
#import "CCRWDCategory.h"

@implementation CCRWDBestCardCategoryCell

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextSetLineWidth(context, 60.0);
    
    CGContextMoveToPoint(context, minX, minY);
    CGContextAddLineToPoint(context, minX, maxY);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, maxX, minY);
    CGContextAddLineToPoint(context, maxX, maxY);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, minX, maxY);
    CGContextAddLineToPoint(context, maxX, maxY);
    CGContextStrokePath(context);
}

- (void)setCategory:(CCRWDCategory *)category
{
    _category = category;
    [_nameLabel setText:_category.name];
}

@end
