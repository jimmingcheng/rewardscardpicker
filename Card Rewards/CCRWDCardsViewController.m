//
//  CCRWDSecondViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardViewController.h"
#import "CCRWDCardsViewController.h"
#import "CCRWDCardRewardCell.h"
#import "CCRWDCategory.h"
#import "CCRWDCreditCard.h"
#import "CCRWDReward.h"
#import "CCRWDCategoryHeadingView.h"

@interface CCRWDCardsViewController ()

@end

@implementation CCRWDCardsViewController
{
    NSMutableDictionary * _visibleCardsByCategoryId;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[_visibleCardsByCategoryId allKeys] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CCRWDCategoryHeadingView *heading = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ItemHeading" forIndexPath:indexPath];
    
    [heading setCategory:[self.categories objectAtIndex:[indexPath indexAtPosition:0]]];

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeading:)];
    [heading addGestureRecognizer:tapRecognizer];
    
    return heading;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CCRWDCategory *category = [self.categories objectAtIndex:section];
    return [[_visibleCardsByCategoryId objectForKey:category.categoryId] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = [indexPath indexAtPosition:0];
    NSInteger j = [indexPath indexAtPosition:1];
    CCRWDCategory *category = [self.categories objectAtIndex:i];
    CCRWDCreditCard *card = [[_visibleCardsByCategoryId objectForKey:category.categoryId] objectAtIndex:j];
    
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

- (void)loadData:(NSArray *)json
{
    NSManagedObjectContext *context = [self managedObjectContext];
    self.creditCards = [CCRWDCreditCard updateFromJSON:json context:context];
    self.categories = [CCRWDCategory updateFromJSON:json context:context];
    self.rewards = [CCRWDReward updateFromJSON:json creditCards:self.creditCards categories:self.categories toContext:context];
    
    [context save:nil];
    
    self.categories = [self.categories sortedArrayUsingComparator:^NSComparisonResult(CCRWDCategory *a, CCRWDCategory *b) { return [a.categoryId compare:b.categoryId]; }];

    self.cardsByCategoryId = [CCRWDReward cardsByCategoryIdFromRewards:self.rewards];
    _visibleCardsByCategoryId = [self.cardsByCategoryId mutableCopy];
    
    [self.collectionView reloadData];
}

- (void)tapHeading:(UITapGestureRecognizer *)recognizer
{
    CCRWDCategory *category = [(CCRWDCategoryHeadingView *)recognizer.view category];
    NSUInteger index = [self.categories indexOfObject:category];
    NSString *catId = category.categoryId;
    NSArray *visibleCardsForCategory = [_visibleCardsByCategoryId objectForKey:catId];
    if ([visibleCardsForCategory count] == 0) {
        [_visibleCardsByCategoryId setObject:[self.cardsByCategoryId objectForKey:catId] forKey:catId];
    }
    else {
        [_visibleCardsByCategoryId setObject:[NSArray array] forKey:catId];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:index]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CCRWDCardRewardCell *cardCell = (CCRWDCardRewardCell *)sender;
    CCRWDCardViewController *cardViewController = (CCRWDCardViewController *)segue.destinationViewController;
    cardViewController.card = cardCell.card;
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
