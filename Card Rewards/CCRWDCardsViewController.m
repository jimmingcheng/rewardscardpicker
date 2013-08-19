//
//  CCRWDSecondViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardsViewController.h"
#import "CCRWDCategoryCell.h"
#import "CCRWDCategory.h"
#import "CCRWDCreditCard.h"
#import "CCRWDItemHeadingView.h"

@interface CCRWDCardsViewController ()

@end

@implementation CCRWDCardsViewController

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
    return [[self.categoriesByCard allKeys] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CCRWDItemHeadingView *heading = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ItemHeading" forIndexPath:indexPath];
    
    heading.label.text = [self.categories objectAtIndex:[indexPath indexAtPosition:0]];
    
    return heading;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *category = [self.categories objectAtIndex:section];
    return [[self.categoriesByCard objectForKey:category] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = [indexPath indexAtPosition:0];
    NSInteger j = [indexPath indexAtPosition:1];
    NSString *categoryStr = [self.categories objectAtIndex:i];
    CCRWDCategory *category = [[self.categoriesByCard objectForKey:categoryStr] objectAtIndex:j];
    
    CCRWDCategoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    cell.label.text = category.name;
    return cell;
}

- (void)loadData:(NSArray *)json
{
    self.creditCards = [CCRWDCreditCard creditCardsFromJSON:json];
    self.categoriesByCard = [CCRWDCreditCard creditCardsByCategory:self.creditCards];
    self.categories = [[self.categoriesByCard allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.collectionView reloadData];
}

@end
