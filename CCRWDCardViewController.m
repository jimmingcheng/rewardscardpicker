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
    _rewardLabel.text = _card.reward;
    
    NSManagedObject *card = [self getCardWithId:_card.cardId fromContext:[self managedObjectContext]];
    [_toggleOwnsCardButton setSelected:(card != nil && [card valueForKey:@"owned"])];
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
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *card = [self getCardWithId:_card.cardId fromContext:context];
    
    NSError *error = nil;
    if (card != nil) {
        [card setValue:[NSNumber numberWithBool:[button isSelected]] forKey:@"owned"];
        [context save:&error];
    }
    else {
        NSManagedObject *newCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
        [newCard setValue:_card.cardId forKey:@"cardId"];
        [newCard setValue:[NSNumber numberWithBool:[button isSelected]] forKey:@"owned"];
        [context save:&error];
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSManagedObject *)getCardWithId:(NSString *)cardId fromContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Card"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cardId == %@", cardId];
    [request setPredicate:predicate];
    NSArray *cards = [[context executeFetchRequest:request error:nil] mutableCopy];
    if (cards.count == 1) {
        return [cards objectAtIndex:0];
    }
    else {
        return nil;
    }
}

@end
