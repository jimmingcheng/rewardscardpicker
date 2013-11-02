//
//  CCRWDTopViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 10/29/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDStartPageViewController.h"

#import "CCRWDCardsViewController.h"
#import "CCRWDRewardsViewController.h"

@interface CCRWDStartPageViewController ()

@end

@implementation CCRWDStartPageViewController

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
    
    [self.cardsButton.layer setCornerRadius:5];
    [self.rewardsButton.layer setCornerRadius:5];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Cards"]) {
        CCRWDCardsViewController *cardsViewController = (CCRWDCardsViewController *)segue.destinationViewController;
        [cardsViewController setCreditCards:self.creditCards];
    }
    else if ([segue.identifier isEqualToString:@"Rewards"]) {
        CCRWDRewardsViewController *rewardsViewController = (CCRWDRewardsViewController *)segue.destinationViewController;
        [rewardsViewController setCreditCards:self.creditCards categories:self.categories rewards:self.rewards];
    }
}

@end
