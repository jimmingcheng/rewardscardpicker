//
//  CCRWDHomeViewController.m
//  Card Rewards
//
//  Created by Jimming Cheng on 8/10/13.
//  Copyright (c) 2013 Jimming Cheng. All rights reserved.
//

#import "CCRWDHomeViewController.h"

@interface CCRWDHomeViewController ()

@end

@implementation CCRWDHomeViewController

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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:@"http://cccal.herokuapp.com/api/0/"]];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
