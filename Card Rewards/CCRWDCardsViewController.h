//
//  CCRWDSecondViewController.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRWDCardsViewController : UICollectionViewController

@property (nonatomic, copy) NSArray * creditCards;
@property (nonatomic, copy) NSArray * categories;
@property (nonatomic, copy) NSDictionary * categoriesByCard;

- (void)loadData:(NSArray *)json;

@end
