//
//  CCRWDCardsViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 10/28/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardsViewController.h"
#import "CCRWDCreditCard.h"
#import "CCRWDCardCell.h"
#import "CCRWDCardViewController.h"

@interface CCRWDCardsViewController ()

@end

@implementation CCRWDCardsViewController

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
	// Do any additional setup after loading the view.
    
    [self.showMyCardsOnlySwitch setOn:_showMyCardsOnly];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%@", [self showableCards]);
    return [[self showableCards] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger j = [indexPath indexAtPosition:1];
    
    CCRWDCreditCard *card = [[self showableCards] objectAtIndex:j];
    
    CCRWDCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    [cell setCard:card];
    
    return cell;
}

- (void)setCreditCards:(NSArray *)creditCards
{
    _creditCards = creditCards;
    [self.collectionView reloadData];
}

- (NSArray *)showableCards
{
    if (_showMyCardsOnly) {
        NSMutableArray *showable = [[NSMutableArray alloc] init];
        for (CCRWDCreditCard *card in self.creditCards) {
            if ([card.owned boolValue]) {
                [showable addObject:card];
            }
        }
        return showable;
    }
    else {
        return self.creditCards;
    }
}

- (IBAction)toggleShowMyCardsOnly:(id)sender
{
    UISwitch *sw = (UISwitch *)sender;
    _showMyCardsOnly = sw.on;
    
    [self.collectionView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CCRWDCardCell *cardCell = (CCRWDCardCell *)sender;
    CCRWDCardViewController *cardViewController = (CCRWDCardViewController *)segue.destinationViewController;
    cardViewController.card = cardCell.card;
}

@end
