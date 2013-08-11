//
//  CCRWDFirstViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCategoriesViewController.h"
#import "CCRWDCreditCard.h"
#import "CCRWDCardCell.h"

@interface CCRWDCategoriesViewController ()

@end

@implementation CCRWDCategoriesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCRWDCardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    CCRWDCreditCard * card = [self.categories objectAtIndex:indexPath.row];
    cell.label.text = card.name;
    return cell;
}

- (void)loadData:(NSArray *)json
{
    self.creditCards = [CCRWDCreditCard creditCardsFromJSON:json];
    [self.collectionView reloadData];
}

@end
