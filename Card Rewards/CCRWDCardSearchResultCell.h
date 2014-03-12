//
//  CCRWDCardSearchResultCell.h
//  Card Rewards
//
//  Created by Jimming Cheng on 1/25/14.
//  Copyright (c) 2014 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDCreditCard;

@interface CCRWDCardSearchResultCell : UITableViewCell

@property (nonatomic) CCRWDCreditCard *card;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
