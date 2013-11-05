//
//  CCRWDSecondViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardViewController.h"
#import "CCRWDCardsViewController.h"
#import "CCRWDRewardsViewController.h"
#import "CCRWDCardRewardCell.h"
#import "CCRWDCategory.h"
#import "CCRWDCreditCard.h"
#import "CCRWDReward.h"
#import "CCRWDCategoryHeadingView.h"
#import "CCRWDAppDelegate.h"

@interface CCRWDRewardsViewController ()

@end

@implementation CCRWDRewardsViewController
{
    NSMutableSet *_expandedCategoryIds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CCRWDAppDelegate *appDelegate = (CCRWDAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.viewStatesPlist = [appDelegate viewStatesPlist];
    _showMyCardsOnly = [[self.viewStatesPlist valueForKey:@"showMyCardsOnly"] boolValue];

    if (_showMyCardsOnly) {
        [self.showMyCardsOnlySegmentedControl setSelectedSegmentIndex:1];
    }
    else {
        [self.showMyCardsOnlySegmentedControl setSelectedSegmentIndex:0];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[[self showableCardsByCategoryId] allKeys] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CCRWDCategoryHeadingView *heading = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CategoryHeading" forIndexPath:indexPath];
    
    [heading setCategory:[[self showableCategories] objectAtIndex:[indexPath indexAtPosition:0]]];

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleCategoryHeading:)];
    [heading addGestureRecognizer:tapRecognizer];
    
    return heading;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CCRWDCategory *category = [[self showableCategories] objectAtIndex:section];
    NSDictionary *showable = [self showableCardsByCategoryId];
    NSDictionary *expanded = [self expandedCardsByCategoryId:showable];
    return [[expanded objectForKey:category.categoryId] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = [indexPath indexAtPosition:0];
    NSInteger j = [indexPath indexAtPosition:1];
    CCRWDCategory *category = [[self showableCategories] objectAtIndex:i];

    CCRWDCreditCard *card = [[[self showableCardsByCategoryId] objectForKey:category.categoryId] objectAtIndex:j];
    
    CCRWDCardRewardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardRewardCell" forIndexPath:indexPath];
    [cell setCard:card];
    for (CCRWDReward *reward in card.rewards) {
        if ([reward.categories containsObject:category]) {
            [cell setReward:reward];
            break;
        }
    }

    return cell;
}

- (void)setShowMyCardsOnly:(bool)showMyCardsOnly
{
    _showMyCardsOnly = showMyCardsOnly;
    [self.viewStatesPlist setObject:[NSNumber numberWithBool:_showMyCardsOnly] forKey:@"showMyCardsOnly"];
}

- (void)setCreditCards:(NSArray *)creditCards categories:(NSArray *)categories rewards:(NSArray *)rewards
{
    _creditCards = creditCards;
    _categories = [categories sortedArrayUsingComparator:^NSComparisonResult(CCRWDCategory *obj1, CCRWDCategory *obj2) {
        if ([obj1.categoryId isEqualToString:@"default_reward"]) {
            return NSOrderedAscending;
        }
        else if ([obj2.categoryId isEqualToString:@"default_reward"]) {
            return NSOrderedDescending;
        }
        else {
            return [obj1.categoryId compare:obj2.categoryId];
        }
    }];
    _rewards = rewards;

    self.cardsByCategoryId = [CCRWDReward cardsByCategoryIdFromRewards:self.rewards];
    _expandedCategoryIds = [[NSMutableSet alloc] init];

    [self.collectionView reloadData];
}

- (NSMutableDictionary *)myCardsByCategoryId
{
    NSMutableDictionary *myCardsByCategoryId = [[NSMutableDictionary alloc] init];
    for (NSString *categoryId in self.cardsByCategoryId) {
        NSMutableArray *myCards = [[NSMutableArray alloc] init];
        for (CCRWDCreditCard *card in [self.cardsByCategoryId objectForKey:categoryId]) {
            if ([card.starred boolValue]) {
                [myCards addObject:card];
            }
        }
        if ([myCards count] > 0) {
            [myCardsByCategoryId setObject:myCards forKey:categoryId];
        }
    }
    return myCardsByCategoryId;
}

- (NSArray *)showableCategories
{
    if (_showMyCardsOnly) {
        NSMutableArray *myCategories = [[NSMutableArray alloc] init];
        for (CCRWDCategory *category in self.categories) {
            for (CCRWDReward *reward in category.rewards) {
                if ([[reward.creditCard starred] boolValue] && ![myCategories containsObject:category]) {
                    [myCategories addObject:category];
                }
            }
        }
        [myCategories sortUsingComparator:^NSComparisonResult(CCRWDCategory *obj1, CCRWDCategory *obj2) {
            if ([obj1.categoryId isEqualToString:@"default_reward"]) {
                return NSOrderedAscending;
            }
            else if ([obj2.categoryId isEqualToString:@"default_reward"]) {
                return NSOrderedDescending;
            }
            else {
                return [obj1.categoryId compare:obj2.categoryId];
            }
        }];

        return myCategories;
    }
    else {
        return self.categories;
    }
}

- (NSDictionary *)showableCardsByCategoryId
{
    if (_showMyCardsOnly) {
        return [self myCardsByCategoryId];
    }
    else {
        return self.cardsByCategoryId;
    }
}

- (NSMutableDictionary *)expandedCardsByCategoryId:(NSDictionary *)cardsByCategoryId
{
    NSMutableDictionary *expanded = [[NSMutableDictionary alloc] init];
    for (NSString *categoryId in cardsByCategoryId) {
        if ([_expandedCategoryIds containsObject:categoryId]) {
            [expanded setObject:[cardsByCategoryId objectForKey:categoryId] forKey:categoryId];
        }
        else {
            [expanded setObject:[NSArray array] forKey:categoryId];
        }
    }
    return expanded;
}

- (void)toggleCategoryHeading:(UITapGestureRecognizer *)recognizer
{
    CCRWDCategoryHeadingView *heading = (CCRWDCategoryHeadingView *)recognizer.view;
    if ([_expandedCategoryIds containsObject:heading.category.categoryId]) {
        [_expandedCategoryIds removeObject:heading.category.categoryId];
    }
    else {
        [_expandedCategoryIds addObject:heading.category.categoryId];
    }
    
    NSUInteger index = [[self showableCategories] indexOfObject:heading.category];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:index]];
}

- (IBAction)toggleShowMyCardsOnly:(id)sender
{
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    if ([segControl selectedSegmentIndex] == 0) {
        [self setShowMyCardsOnly:false];
    }
    else {
        [self setShowMyCardsOnly:true];
    }

    [self.collectionView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Card"]) {
        CCRWDCardRewardCell *cardCell = (CCRWDCardRewardCell *)sender;
        CCRWDCardViewController *cardViewController = (CCRWDCardViewController *)segue.destinationViewController;
        cardViewController.card = cardCell.card;
    }
}

@end
