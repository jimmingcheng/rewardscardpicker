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

@interface CCRWDCardViewController ()

@end

@implementation CCRWDCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _nameLabel.text = _card.name;
    _cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _card.cardId]];

    [_toggleStarButton.layer setCornerRadius:4];
    [self updateToggleStarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [cell.rewardLabel setText:[NSString stringWithFormat:@"%@%@", reward.amount, reward.unit]];
    [cell.categoriesLabel setText:[categories componentsJoinedByString:@", "]];
    
    [self.rewardDetailsView sizeToFit];
    
    return cell;
}

- (void)updateToggleStarButton
{
    if ([[_card starred] boolValue]) {
        [_toggleStarButton setBackgroundColor:[self.view tintColor]];
    }
    else {
        [_toggleStarButton setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (IBAction)toggleStar:(UITapGestureRecognizer *)tap
{
    [_card setStarred:[NSNumber numberWithBool:![[_card starred] boolValue]]];
    [self updateToggleStarButton];
}

@end
