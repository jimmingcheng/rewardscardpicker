//
//  CCRWDCategoryCardsViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/10/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCategoryCardsViewController.h"
#import "CCRWDCategoryCardCell.h"

@interface CCRWDCategoryCardsViewController ()

@end

@implementation CCRWDCategoryCardsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[CCRWDCategoryCardCell class] forCellWithReuseIdentifier:@"CategoryCardCell2"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCRWDCategoryCardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCardCell2" forIndexPath:indexPath];
    cell.label.text = @"yoyoy";
    return cell;
}

@end
