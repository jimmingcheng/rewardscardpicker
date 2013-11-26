//
//  CCRWDBestCardCategoryCell.h
//  Card Rewards
//
//  Created by Jimming Cheng on 11/25/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDCategory;

@interface CCRWDBestCardCategoryCell : UICollectionViewCell

@property (nonatomic) CCRWDCategory *category;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
