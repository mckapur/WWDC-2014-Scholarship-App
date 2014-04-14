//
//  RKIntentFactory.h
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "UIView+Styles.h"

#import "RKIntent.h"
#import "RKDataStore.h"

/**
 RKIntentAssembly 
 is the site of native
 intent assembly
 */

static __unused NSString* const kBlurredBackgroundImagePath = @"blurredBackground";

static __unused NSString* const kContentURL = @"inent_content_url";
static __unused NSString* const kContentScreenshots = @"intent_content_screenshots";
static __unused NSString* const kContentTitle = @"intent_content_title";
static __unused NSString* const kContentBody = @"inent_content_body";
static __unused NSString* const kContentIcon = @"intent_content_icon";

static __unused NSString* const kPersonalWebsiteURL = @"http://www.rohankapur.com";
static __unused NSString* const kSchoolURL = @"http://www.uwcsea.edu.sg";
static __unused NSString* const kLeapDuinoURL = @"https://vine.co/v/hF90YLKWX2U";
static __unused NSString* const kThisIsAwkwardURL = @"http://thisisawkward.rohankapur.com";
static __unused NSString* const kVideoURL = @"http://www.youtube.com/watch?v=i9KYf_e1HE4";

typedef enum {
    
    kIntentTypeWit = 0,
    kIntentTypeWolframAlpha
    
} IntentTypes;

/**
 RKIntentAssembly assembles the 
 native hard-coded intents, with
 most effort involving initializing
 and populating the 'detailView' property
 */

@interface RKIntentAssembly : NSObject

+ (void)assembleIntents;

@end