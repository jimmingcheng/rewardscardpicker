//
//  CCRWDCategoryCell.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/9/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDCreditCard;
@class CCRWDReward;

@interface CCRWDCardRewardCell : UICollectionViewCell

@property (nonatomic) CCRWDCreditCard *card;
@property (nonatomic) CCRWDReward *reward;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UIButton *toggleStarButton;

- (IBAction)toggleStar:(id)sender;

@end
