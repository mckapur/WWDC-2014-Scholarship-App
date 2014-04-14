//
//  RKDataStore.h
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RKIntent.h"

/**
 RKDataStore is
 the site for intent
 data fetch and write
 */

static __unused NSString* const kErrorDomainIntentNotFound = @"DataStoreError_IntentNotFound";
static __unused NSString* const kErrorDescriptionIntentNotFound = @"I couldn't understand what you were asking.";
static __unused NSInteger const kErrorCodesIntentNotFound = 404; // HTTP codes. Because why not.


/**
 The RKDataStore holds and
 indexes all native intents ready
 for access
 */
@interface RKDataStore : NSObject

+ (RKDataStore *)sharedIntentStore;

- (void)readIntentsForIDs:(NSArray *)IDS withCompletionHandler:(void (^)(NSError *error, NSArray *intents))callback;
- (void)writeIntents:(NSArray *)intents;

/**
 The intents
 */
@property (nonatomic, strong) NSMutableDictionary *intents;

@end
