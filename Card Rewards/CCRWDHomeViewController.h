//
//  CCRWDHomeViewController.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/10/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRWDCardsViewController.h"
#import "CCRWDCategoriesViewController.h"

@interface CCRWDHomeViewController : UITabBarController

@property (weak, nonatomic) IBOutlet CCRWDCardsViewController * cardViewController;
@property (weak, nonatomic) IBOutlet CCRWDCategoriesViewController * categoriesViewController;

@end
