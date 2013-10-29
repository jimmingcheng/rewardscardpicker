//
//  CCRWDSecondViewController.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/6/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRWDCategory;

@interface CCRWDCardsViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, copy) NSArray * creditCards;
@property (nonatomic, copy) NSArray * categories;
@property (nonatomic, copy) NSArray * rewards;
@property (nonatomic, copy) NSDictionary * cardsByCategoryId;
@property (weak, nonatomic) IBOutlet UISwitch *showMyCardsOnlySwitch;

- (void)loadData:(NSArray *)json;
- (void)toggleCategoryHeading:(UITapGestureRecognizer *)recognizer;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

- (IBAction)toggleShowMyCardsOnly:(id)sender;

@end
