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
    _nameLabel.text = _card.name;
    _cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _card.cardId]];

    [_toggleStarButton setSelected:[_card.starred boolValue]];
    [self updateToggleStarButton:_toggleStarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateToggleStarButton:(UIButton *)button
{
    if ([button isSelected]) {
        [button setBackgroundColor:[self.view tintColor]];
    }
    else {
        [button setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (IBAction)toggleStar:(id)sender
{    
    UIButton *button = (UIButton *)sender;
    [button setSelected:![button isSelected]];
 
    [self updateToggleStarButton:button];
    
    [_card setStarred:[NSNumber numberWithBool:[button isSelected]]];
}

@end
