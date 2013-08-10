//
//  CCRWDFirstViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCategoriesViewController.h"
#import "CCRWDCategory.h"
#import "CCRWDCategoryCell.h"

@interface CCRWDCategoriesViewController ()

@end

@implementation CCRWDCategoriesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.categories = [CCRWDCategory loadAllCategories];
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
    CCRWDCategoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    CCRWDCategory * category = [self.categories objectAtIndex:indexPath.row];
    cell.label.text = category.name;
    return cell;
}

@end
