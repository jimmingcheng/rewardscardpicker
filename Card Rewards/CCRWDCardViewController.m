//
//  CCRWDCardViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 10/20/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardViewController.h"

@interface CCRWDCardViewController ()

@end

@implementation CCRWDCardViewController

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
    _nameLabel.text = _card.cardId;

    [_toggleOwnsCardButton setSelected:[_card.owned boolValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleOwnsCard:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setSelected:![button isSelected]];
    
    [_card setOwned:[NSNumber numberWithBool:[button isSelected]]];
}

@end
