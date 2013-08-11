//
//  CCRWDSecondViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardsViewController.h"
#import "CCRWDCardCell.h"
#import "CCRWDCreditCard.h"
#import "CCRWDCategoryHeadingView.h"

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
    return [[self.cardsByCategory allKeys] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CCRWDCategoryHeadingView *heading = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CategoryHeading" forIndexPath:indexPath];
    
    heading.label.text = [self.categories objectAtIndex:[indexPath indexAtPosition:0]];
    
    return heading;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *category = [self.categories objectAtIndex:section];
    return [[self.cardsByCategory objectForKey:category] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = [indexPath indexAtPosition:0];
    NSInteger j = [indexPath indexAtPosition:1];
    NSString *category = [self.categories objectAtIndex:i];
    CCRWDCreditCard *card = [[self.cardsByCategory objectForKey:category] objectAtIndex:j];
    
    CCRWDCardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    cell.label.text = card.name;
    return cell;
}

- (void)loadData:(NSArray *)json
{
    self.creditCards = [CCRWDCreditCard creditCardsFromJSON:json];
    self.cardsByCategory = [CCRWDCreditCard creditCardsByCategory:self.creditCards];
    self.categories = [[self.cardsByCategory allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSLog(@"%@", self.cardsByCategory);
    [self.collectionView reloadData];
}

@end
