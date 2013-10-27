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
    NSMutableSet *_expandedCategoryIds;
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

- (void)loadData:(NSArray *)json
{
    NSManagedObjectContext *context = [self managedObjectContext];
    self.creditCards = [CCRWDCreditCard updateFromJSON:json context:context];
    self.categories = [CCRWDCategory updateFromJSON:json context:context];
    self.rewards = [CCRWDReward updateFromJSON:json creditCards:self.creditCards categories:self.categories toContext:context];
    
    [context save:nil];
    
    self.categories = [self.categories sortedArrayUsingComparator:^NSComparisonResult(CCRWDCategory *obj1, CCRWDCategory *obj2) {
        return [obj1.categoryId compare:obj2.categoryId];
    }];

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
            if ([card.owned boolValue]) {
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
    if ([self.toggleMyCardsControl selectedSegmentIndex] == 0) {
        NSMutableArray *myCategories = [[NSMutableArray alloc] init];
        for (CCRWDCategory *category in self.categories) {
            for (CCRWDReward *reward in category.rewards) {
                if ([[reward.creditCard owned] boolValue]) {
                    [myCategories addObject:category];
                }
            }
        }
        [myCategories sortUsingComparator:^NSComparisonResult(CCRWDCategory *obj1, CCRWDCategory *obj2) {
            return [obj1.categoryId compare:obj2.categoryId];
        }];

        return myCategories;
    }
    else {
        return self.categories;
    }
}

- (NSDictionary *)showableCardsByCategoryId
{
    if ([self.toggleMyCardsControl selectedSegmentIndex] == 0) {
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

- (IBAction)toggleMyCards:(id)sender
{
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    if ([segControl selectedSegmentIndex] == 0) {
        //NSLog(@"0");
    }
    else {
        //NSLog(@"1");
    }
    [self.collectionView reloadData];

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
