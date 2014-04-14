//
//  RKDataStore.m
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "RKDataStore.h"

@implementation RKDataStore
@synthesize intents;

#pragma mark - Reading

- (void)readIntentsForIDs:(NSArray *)IDs withCompletionHandler:(void (^)(NSError *error, NSArray *intents))callback {
    
    NSError *error = nil;
    
    NSMutableArray *returnedIntents = [[NSMutableArray alloc] init];
    
    for (NSString *ID in IDs) {

        if (self.intents[ID])
            [returnedIntents addObject:self.intents[ID]];
        else
            error = [[NSError alloc] initWithDomain:kErrorDomainIntentNotFound code:kErrorCodesIntentNotFound userInfo:@{NSLocalizedDescriptionKey: kErrorDescriptionIntentNotFound}];
    }
    
    callback(error, returnedIntents);
}

#pragma mark - Writing

- (void)writeIntents:(NSArray *)intentsToWrite {
    
    for (RKIntent *intent in intentsToWrite) {
        
        self.intents[intent.ID] = intent;
    }
}

#pragma mark - Initialization

- (id)init {
    
    if (self = [super init])
        self.intents = [[NSMutableDictionary alloc] init];
    
    return self;
}

+ (RKDataStore *)sharedIntentStore {
    
    static RKDataStore *sharedIntentStore;
    
    @synchronized (self) {
        
        if (!sharedIntentStore)
            sharedIntentStore = [[RKDataStore alloc] init];
        
        return sharedIntentStore;
    }
}

@end