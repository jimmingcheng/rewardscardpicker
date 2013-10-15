//
//  CCRWDCategoryHeadingView.h
//  Card Rewards
//
//  Created by Jimming Cheng on 8/11/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRWDItemHeadingView : UICollectionReusableView

@property (nonatomic, copy) NSString * key;

@property (weak, nonatomic) IBOutlet UILabel * label;

@end
