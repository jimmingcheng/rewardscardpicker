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
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor] );
    CGContextSetLineWidth(context, 100.0);
    CGContextStrokePath(context);
}

- (void)setCategory:(CCRWDCategory *)category
{
    _category = category;
    [_nameLabel setText:_category.name];
}

@end
