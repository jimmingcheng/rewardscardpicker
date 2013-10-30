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
#import "CCRWDAppDelegate.h"

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
    
    CCRWDAppDelegate *appDelegate = (CCRWDAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.viewStatesPlist = [appDelegate viewStatesPlist];
    _showMyCardsOnly = [[self.viewStatesPlist valueForKey:@"showMyCardsOnly"] boolValue];
    
    if (_showMyCardsOnly) {
        [self.showMyCardsOnlySegmentedControl setSelectedSegmentIndex:1];
    }
    else {
        [self.showMyCardsOnlySegmentedControl setSelectedSegmentIndex:0];
    }
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

- (void)setShowMyCardsOnly:(bool)showMyCardsOnly
{
    _showMyCardsOnly = showMyCardsOnly;
    [self.viewStatesPlist setObject:[NSNumber numberWithBool:_showMyCardsOnly] forKey:@"showMyCardsOnly"];
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
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    if ([segControl selectedSegmentIndex] == 0) {
        [self setShowMyCardsOnly:false];
    }
    else {
        [self setShowMyCardsOnly:true];
    }
    
    [self.collectionView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CCRWDCardCell *cardCell = (CCRWDCardCell *)sender;
    CCRWDCardViewController *cardViewController = (CCRWDCardViewController *)segue.destinationViewController;
    cardViewController.card = cardCell.card;
}

@end
