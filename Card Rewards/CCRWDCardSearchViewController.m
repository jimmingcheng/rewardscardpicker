//
//  CCRWDCardSearchViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 1/24/14.
//  Copyright (c) 2014 Jimming Cheng. All rights reserved.
//

#import "CCRWDCardViewController.h"
#import "CCRWDCardSearchViewController.h"
#import "CCRWDCardSearchResultCell.h"
#import "CCRWDAppDelegate.h"
#import "CCRWDCreditCard.h"

@interface CCRWDCardSearchViewController ()

@end

@implementation CCRWDCardSearchViewController
{
    NSArray *_allCards;
    NSArray *_searchResults;
    NSString *_prevSearchString;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        CCRWDAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext * context = [appDelegate managedObjectContext];
        _allCards = [CCRWDCreditCard cardsFromContext:context];
        _searchResults = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [_allCards count];
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView){
        return [_searchResults count];
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger j = [indexPath indexAtPosition:1];
    
    CCRWDCardSearchResultCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CardSearchResultCell" forIndexPath:indexPath];
    if (tableView == self.tableView) {
    
        [cell setCard:[_allCards objectAtIndex:j]];
    
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCreditCard:)];
        [cell addGestureRecognizer:tapRecognizer];
    
        return cell;
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        [cell setCard:[_searchResults objectAtIndex:j]];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCreditCard:)];
        [cell addGestureRecognizer:tapRecognizer];
        
        return cell;
    }
    else {
        return nil;
    }
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = self.tableView.rowHeight;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if ([searchString length] == 0) {
        _searchResults = [[NSArray alloc] init];
        [self.searchDisplayController.searchResultsTableView reloadData];
        return YES;
    }
    else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchCreditCards:) object:_prevSearchString];
        [self performSelector:@selector(searchCreditCards:) withObject:searchString];
        _prevSearchString = searchString;
        return NO;
    }
}

- (void)searchCreditCards:(NSString *)searchString
{
    CCRWDAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext * context = [appDelegate managedObjectContext];
    
    _searchResults = [CCRWDCreditCard searchCardsWithWords:searchString context:context];

    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (void)addCreditCard:(UITapGestureRecognizer *)recognizer
{
    CCRWDCardSearchResultCell *cell = (CCRWDCardSearchResultCell *)recognizer.view;
    [self performSegueWithIdentifier:@"Card" sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Card"]) {
        CCRWDCardSearchResultCell *cell = (CCRWDCardSearchResultCell *)sender;
        CCRWDCardViewController *cardVC = (CCRWDCardViewController *)segue.destinationViewController;
        [cardVC setCard:cell.card];
    }
}

@end
