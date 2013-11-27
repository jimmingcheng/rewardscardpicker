//
//  CCRWDBestCardViewController.h
//  Card Rewards
//
//  Created by Jimming Cheng on 11/23/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CATEGORY_CELL_HEIGHT 40.0
#define MAGNIFIED_CELL_HEIGHT 200.0
#define NUM_CELLS_PRECEDING_MAGNIFY 4

@interface CCRWDBestCardViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (copy) NSArray *cards;
@property (copy) NSArray *categories;
@property (copy) NSArray *rewards;
@property (copy) NSDictionary * cardsByCategoryId;

@property (weak, nonatomic) IBOutlet UICollectionView *categoriesListView;
@property (weak, nonatomic) IBOutlet UICollectionView *magnifiedView;
@property (weak, nonatomic) IBOutlet UIView *glassView;
@property (weak, nonatomic) IBOutlet UIView *controlPanel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *myOrAllRewardsSelector;

- (void)setCards:(NSArray *)cards categories:(NSArray *)categories rewards:(NSArray *)rewards;

- (IBAction)goBack:(id)sender;

@end
