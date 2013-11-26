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
@property (copy, readonly) NSArray *cards;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

- (void)setCategory:(CCRWDCategory *)category cards:(NSArray *)cards;

@end
