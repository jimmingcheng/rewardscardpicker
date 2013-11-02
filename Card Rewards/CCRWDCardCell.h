//
//  CCRWDCardCell.h
//  Card Rewards
//
//  Created by Jimming Cheng on 10/28/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDCreditCard;

@interface CCRWDCardCell : UICollectionViewCell

@property (nonatomic) CCRWDCreditCard *card;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UIButton *toggleStarButton;

- (IBAction)toggleStar:(id)sender;

@end
