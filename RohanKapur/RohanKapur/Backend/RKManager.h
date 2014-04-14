//
//  RKManager.h
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "Wit.h"
#import "XMLDictionary.h"

#import "RKConfig.h"
#import "RKIntent.h"
#import "RKIntentAssembly.h"
#import "RKDataStore.h"

/**
 RKManager manages queries to Wit
 and Wolfram Alpha, organizes them
 and returns back to the
 RKIntentSearchViewController
 */

static __unused NSString* const kWolframAlphaQueryEndpoint = @"http://api.wolframalpha.com/v2/query";

static __unused NSString* const kWitExpressionQueryEndpoint = @"https://api.wit.ai/message";
static __unused NSString* const kWitResponseKeyResponse = @"response";
static __unused NSString* const kWitResponseKeyError = @"error";
static __unused NSString* const kWitResponseKeyOutcome = @"outcome";
static __unused NSString* const kWitResponseKeyProgress = @"progress";
static __unused NSString* const kWitResponseKeyURL = @"url";
static __unused NSString* const kWitResponseKeyBody = @"msg_body";

static __unused NSString* const kWitNotificationAudioStart = @"WITRecordingStarted";
static __unused NSString* const kWitNotificationAudioEnd = @"WITRecordingStopped";
static __unused NSString* const kRiriStartedSystemSoundCompleted = @"RiriStartedSystemSoundCompleted";

static __unused NSString* const kErrorDomainIntentNotRecognized = @"IntentNotRecognized";
static __unused NSString* const kErrorDescriptionIntentNotRecognized = @"I couldn't understand what you were asking.";
static __unused NSInteger const kErrorCodesIntentNotRecognized = 403;

@protocol RKManagerDelegate <NSObject>

- (void)witRecognizedVoice:(NSString *)body withAssociatedIntents:(NSArray *)intents;
- (void)witRecognizedExpressionWithAssociatedIntents:(NSArray *)intents;
- (void)witErrorOccurred:(NSError *)error;

- (void)witDidStartListening;
- (void)witDidStopListening;

@end

@interface RKManager : NSObject <WitDelegate>

+ (RKManager *)sharedManager;

/**
 The manager's delegate
 (in context RKIntentSearchViewController)
 */
@property (strong, nonatomic) id<RKManagerDelegate> delegate;

- (void)queryWitForExpression:(NSString *)expression;

@end
