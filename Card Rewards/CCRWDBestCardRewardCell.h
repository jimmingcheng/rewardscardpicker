//
//  CCRWDBestCardCardCell.h
//  Card Rewards
//
//  Created by Jimming Cheng on 11/27/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDReward;

@interface CCRWDBestCardRewardCell : UICollectionViewCell

@property (nonatomic) CCRWDReward *reward;

@property (weak, nonatomic) IBOutlet UIButton *cardButton;

@end
