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
{
    NSMutableDictionary * _visibleCardsByCategory;
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
    return [[_visibleCardsByCategory allKeys] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CCRWDItemHeadingView *heading = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ItemHeading" forIndexPath:indexPath];
    
    heading.key = [self.categories objectAtIndex:[indexPath indexAtPosition:0]];
    heading.label.text = heading.key;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeading:)];
    [heading addGestureRecognizer:tapRecognizer];
    
    return heading;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *category = [self.categories objectAtIndex:section];
    return [[_visibleCardsByCategory objectForKey:category] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = [indexPath indexAtPosition:0];
    NSInteger j = [indexPath indexAtPosition:1];
    NSString *categoryStr = [self.categories objectAtIndex:i];
    CCRWDCategory *category = [[_visibleCardsByCategory objectForKey:categoryStr] objectAtIndex:j];
    
    CCRWDCategoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    cell.label.text = category.name;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected");
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"deselected");
}

- (void)loadData:(NSArray *)json
{
    self.creditCards = [CCRWDCreditCard creditCardsFromJSON:json];
    self.cardsByCategory = [CCRWDCreditCard creditCardsByCategory:self.creditCards];
    self.categories = [[self.cardsByCategory allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    _visibleCardsByCategory = [self.cardsByCategory mutableCopy];
    [self.collectionView reloadData];
}

- (void)tapHeading:(UITapGestureRecognizer *)recognizer
{
    NSString *category = [(CCRWDItemHeadingView *)recognizer.view key];
    NSUInteger index = [self.categories indexOfObject:category];
    NSArray *visibleCardsForCategory = [_visibleCardsByCategory objectForKey:category];
    if ([visibleCardsForCategory count] == 0) {
        [_visibleCardsByCategory setObject:[self.cardsByCategory objectForKey:category] forKey:category];
    }
    else {
        [_visibleCardsByCategory setObject:[NSArray array] forKey:category];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:index]];
}

@end
