//
//  CCRWDCardViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 10/20/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardViewController.h"
#import "CCRWDRewardDetailCell.h"
#import "CCRWDCategory.h"
#import "CCRWDReward.h"
#import "CCRWDEVent.h"

@interface CCRWDCardViewController ()

@end

@implementation CCRWDCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _nameLabel.text = _card.name;
    _cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _card.cardId]];

    [_starredSwitch setOn:[_card.starred boolValue]];
    
    [_rewardDetailsFrameView.layer setCornerRadius:4];
    [_rewardDetailsFrameView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [_rewardDetailsFrameView.layer setBorderWidth:1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[_card rewards] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = [indexPath indexAtPosition:1];

    NSMutableArray *rewards = [[_card.rewards allObjects] mutableCopy];
    [rewards sortUsingComparator:^NSComparisonResult(CCRWDReward *obj1, CCRWDReward *obj2) {
        return [obj2.amount compare:obj1.amount];
    }];
    CCRWDReward *reward = [rewards objectAtIndex:i];
    
    CCRWDRewardDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RewardDetailCell" forIndexPath:indexPath];
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    for (CCRWDCategory *category in [reward categories]) {
        [categories addObject:[category name]];
    }
    
    if ([reward.unit isEqualToString:@"cash back"]) {
        [cell.rewardLabel setText:[NSString stringWithFormat:@"%@%%", reward.amount]];
    }
    else {
        [cell.rewardLabel setText:[NSString stringWithFormat:@"%@x", reward.amount]];
    }
    [cell.rewardLabel.layer setCornerRadius:10];
    [cell.categoriesLabel setText:[categories componentsJoinedByString:@", "]];
    [_rewardUnitLabel setText:reward.unit];
        
    return cell;
}



- (IBAction)toggleStar:(id)sender
{
    UISwitch *starredSwitch = (UISwitch *)sender;
    [_card setStarred:[NSNumber numberWithBool:starredSwitch.on]];
    [CCRWDEvent queueEventWithType:@"ToggleCard" key:@"value" value:[NSNumber numberWithBool:starredSwitch.on]];
}

@end
