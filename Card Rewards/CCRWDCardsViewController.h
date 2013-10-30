//
//  CCRWDCardsViewController.h
//  Card Rewards
//
//  Created by Jimming Cheng on 10/28/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRWDCardsViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, copy) NSArray * creditCards;
@property (nonatomic) bool showMyCardsOnly;
@property NSMutableDictionary *viewStatesPlist;
@property (weak, nonatomic) IBOutlet UISegmentedControl *showMyCardsOnlySegmentedControl;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

- (IBAction)toggleShowMyCardsOnly:(id)sender;

@end
