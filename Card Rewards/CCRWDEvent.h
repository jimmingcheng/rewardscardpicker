//
//  CCRWDEvent.h
//  Card Rewards
//
//  Created by Jimming Cheng on 4/13/14.
//  Copyright (c) 2014 Jimming Cheng. All rights reserved.
//

#import <CoreData/CoreData.h>

#define EVENT_BATCH_SIZE 100

@interface CCRWDEvent : NSObject

@property (nonatomic) NSString *type;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSMutableDictionary *data;

- (id)initWithType:(NSString *)type;

+ (NSMutableArray *)queuedEvents;
+ (void)queueEventWithType:(NSString *)type;
+ (void)queueEventWithType:(NSString *)type key:(NSString *)key value:(id)obj;
+ (void)sendQueuedEvents;
+ (void)sendBatchOfEvents:(NSArray *)events;
+ (NSString *)jsonDate:(NSDate *)date;

@end
