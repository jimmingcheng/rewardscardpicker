//
//  CCRWDCategoryHeadingView.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/11/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCategoryHeadingView.h"
#import "CCRWDCategory.h"

@implementation CCRWDCategoryHeadingView

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

- (void)setCategory:(CCRWDCategory *)category
{
    _category = category;
    _label.text = [_category.categoryId stringByReplacingOccurrencesOfString:@"_" withString:@" "];
}

@end
