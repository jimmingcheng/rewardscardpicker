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

@interface CCRWDCardsViewController ()

@end

@implementation CCRWDCardsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.creditCards = [CCRWDCreditCard loadAllCreditCards];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.creditCards.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCRWDCardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    CCRWDCreditCard * card = [self.creditCards objectAtIndex:indexPath.row];
    cell.label.text = card.name;
    return cell;
}

@end
