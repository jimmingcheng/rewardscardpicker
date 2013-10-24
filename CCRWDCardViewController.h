//
//  CCRWDCardViewController.h
//  Card Rewards
//
//  Created by Jimming Cheng on 10/20/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRWDCreditCard.h"

@interface CCRWDCardViewController : UIViewController

@property (weak, nonatomic) CCRWDCreditCard *card;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIButton *toggleOwnsCardButton;

- (IBAction)toggleOwnsCard:(id)sender;

@end
