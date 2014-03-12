//
//  CCRWDCardSearchViewController.h
//  Card Rewards
//
//  Created by Jimming Cheng on 1/24/14.
//  Copyright (c) 2014 Jimming Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRWDCardSearchViewController : UITableViewController<UISearchDisplayDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
