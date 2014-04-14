//
//  CCRWDEvent.m
//  Card Rewards
//
//  Created by Jimming Cheng on 4/13/14.
//  Copyright (c) 2014 Jimming Cheng. All rights reserved.
//

#import "CCRWDEvent.h"

@implementation CCRWDEvent

- (id)initWithType:(NSString *)type
{
    self = [super init];
    if (self) {
        [self setType:type];
        [self setDate:[NSDate date]];
        [self setData:[[NSMutableDictionary alloc] init]];
    }
    return self;
}

+ (NSMutableArray *)queuedEvents
{
    static NSMutableArray *_queuedEvents = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _queuedEvents = [[NSMutableArray alloc] init];
    });
    return _queuedEvents;
}

+ (void)queueEventWithType:(NSString *)type
{
    CCRWDEvent *event = [[CCRWDEvent alloc] initWithType:type];
    [[CCRWDEvent queuedEvents] addObject:event];
}

+ (void)queueEventWithType:(NSString *)type key:(NSString *)key value:(id)obj
{
    CCRWDEvent *event = [[CCRWDEvent alloc] initWithType:type];
    [event.data setObject:obj forKey:key];
    [[CCRWDEvent queuedEvents] addObject:event];}

+ (void)sendQueuedEvents
{
    NSMutableArray *queuedEvents = [CCRWDEvent queuedEvents];
    while (queuedEvents.count > 0) {
        NSMutableArray *batch = [[NSMutableArray alloc] initWithCapacity:queuedEvents.count];
        int i = EVENT_BATCH_SIZE;
        while (queuedEvents.count > 0 && i > 0) {
            CCRWDEvent *event = [queuedEvents objectAtIndex:0];
            [queuedEvents removeObjectAtIndex:0];
            i--;
            
            [event.data setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"dvid"];
            [event.data setObject:event.type forKey:@"type"];
            [event.data setObject:[CCRWDEvent jsonDate:event.date] forKey:@"date"];
            [batch addObject:event.data];
        }
        [CCRWDEvent sendBatchOfEvents:batch];
    }
}

+ (void)sendBatchOfEvents:(NSArray *)events
{
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:events options:kNilOptions error:&error];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.rewardscardpicker.com/log/0/"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", data);
        NSLog(@"%@", response);
        NSLog(@"%@", error);
    }] resume];
}

+ (NSString *)jsonDate:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    return [outputFormatter stringFromDate:date];
}

@end
