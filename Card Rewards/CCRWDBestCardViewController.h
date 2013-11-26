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

@property (copy, readonly) NSArray *creditCards;
@property (copy, readonly) NSArray *categories;
@property (copy, readonly) NSArray *rewards;
@property (copy, readonly) NSDictionary * cardsByCategoryId;

@property (weak, nonatomic) IBOutlet UICollectionView *categoriesListView;
@property (weak, nonatomic) IBOutlet UICollectionView *magnifiedView;
@property (weak, nonatomic) IBOutlet UIView *glassView;

- (void)setCreditCards:(NSArray *)creditCards categories:(NSArray *)categories rewards:(NSArray *)rewards;

@end
