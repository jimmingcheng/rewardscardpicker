//
//  CCRWDSecondViewController.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDCategory;

@interface CCRWDRewardsViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, copy, readonly) NSArray * creditCards;
@property (nonatomic, copy, readonly) NSArray * categories;
@property (nonatomic, copy, readonly) NSArray * rewards;
@property (nonatomic, copy) NSDictionary * cardsByCategoryId;
@property (weak, nonatomic) IBOutlet UISwitch *showMyCardsOnlySwitch;

- (void)setCreditCards:(NSArray *)creditCards categories:(NSArray *)categories rewards:(NSArray *)rewards;
- (void)toggleCategoryHeading:(UITapGestureRecognizer *)recognizer;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

- (IBAction)toggleShowMyCardsOnly:(id)sender;

@end
