//
//  CCRWDMyBestCardViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 11/26/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDMyBestCardViewController.h"
#import "CCRWDCreditCard.h"
#import "CCRWDReward.h"

@interface CCRWDMyBestCardViewController ()

@end

@implementation CCRWDMyBestCardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myOrAllRewardsSelector setSelectedSegmentIndex:0];
}

- (void)setCards:(NSArray *)cards categories:(NSArray *)categories rewards:(NSArray *)rewards
{
    _allCards = cards;
    _allCategories = categories;
    _allRewards = rewards;
    
    NSMutableArray *myCards = [[NSMutableArray alloc] init];
    NSMutableSet *myRewards = [[NSMutableSet alloc] init];
    for (CCRWDCreditCard *card in _allCards) {
        if ([card.starred boolValue]) {
            [myCards addObject:card];
            [myRewards addObjectsFromArray:[card.rewards allObjects]];
        }
    }
    
    NSMutableSet *myCategories = [[NSMutableSet alloc] init];
    for (CCRWDReward *reward in myRewards) {
        [myCategories addObjectsFromArray:[reward.categories allObjects]];
    }
    
    [super setCards:myCards categories:[myCategories allObjects] rewards:[myRewards allObjects]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AllCards"]) {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        CCRWDBestCardViewController *bestVC = (CCRWDBestCardViewController *)[navController.viewControllers objectAtIndex:0];
        [bestVC setCards:_allCards categories:_allCategories rewards:_allRewards];
    }
    else {
        [super prepareForSegue:segue sender:sender];
    }
}

@end
