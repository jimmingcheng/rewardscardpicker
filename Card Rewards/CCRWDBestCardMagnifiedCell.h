//
//  CCRWDBestCardCell.h
//  Card Rewards
//
//  Created by Jimming Cheng on 11/24/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDCategory;

@interface CCRWDBestCardMagnifiedCell : UICollectionViewCell

@property (readonly) CCRWDCategory *category;
@property (copy, readonly) NSArray *rewards;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *rewardsCollectionView;

- (void)setCategory:(CCRWDCategory *)category rewards:(NSArray *)rewards;

@end
