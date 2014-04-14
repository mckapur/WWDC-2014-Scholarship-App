//
//  RKIntentSearchViewController.h
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVSpeechSynthesis.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>

#import "FBShimmeringView.h"
#import "UIView+Styles.h"
#import "RKIntentTableViewCell.h"

#import "RKManager.h"

#import "RKIntentDetailViewController.h"

/**
 RKIntentSearchViewController
 provides a frontend to 
 voice and text search for intents
 on http://wit.ai - and sort
 them into a table view, ready
 for further expansion
 */

static __unused NSString* const kHeaderBlurredBannerImagePath = @"blurredHeader.png";

static __unused NSString* const kAudioAudioStart = @"audioStart.caf";
static __unused NSString* const kAudioAudioStop = @"audioStop.caf";

static __unused NSString* const kFBShimmeringWitMic = @"FBSHIMMERING_WITMIC";
static __unused NSString* const kFBShimmeringCheatSheetLabel = @"FBSHIMMERING_CHEATSHEETLABEL";

static __unused NSInteger const kCheatSheetLabelID = 200;

static __unused NSString* const kIntentTableView = @"INTENTTABLEVIEW_TABLEID";
static __unused NSString* const kCheatSheetTableView = @"CHEATSHEETTABLEVIEW_TABLEID";

static __unused NSString* const kIntentCellIdentifier = @"INTENTTABLEVIEW_CELLID";
static __unused NSString* const kCheatSheetCellIdentifier = @"CHEATSHEETTABLEVIEW_CELLID";

typedef enum {
    
    kIntentFilterTypeSupersOnly = 0,
    kIntentFilterTypeLowersOnly
    
} IntentFilterTypes;

@interface RKIntentSearchViewController : UIViewController <RKManagerDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, AVAudioPlayerDelegate, UITextFieldDelegate>

/**
 The cheat sheet data
 */
@property (strong, nonatomic) NSArray *cheatSheetData;

/**
 The view controller's
 table view of intents
 */
@property (strong, nonatomic) UITableView *intentTableView;

/**
 The view controller's
 intent detail view controller
 */
@property (strong, nonatomic) RKIntentDetailViewController *intentDetailViewController;

/**
 The shimmering layer
 for the statusLabel
 to indicate loading
 */
@property (strong, nonatomic) FBShimmeringView *loadingShimmeringView;

/**
 The view controller's
 scroll view that seperates
 the cheat sheet from the 
 main view
 */
@property (strong, nonatomic) UIScrollView *scrollView;

/**
 The view controller's
 status text view that displays
 loading, errors and 
 an opening introduction
 */
@property (strong, nonatomic) UITextView *statusTextView;

/**
 The view controller's
 Wit (http://wit.ai)
 microphone button
 */
@property (strong, nonatomic) WITMicButton *witMicButton;

/**
 The view controller's
 Wit text field
 */
@property (strong, nonatomic) UITextField *witTextField;

/**
 The view controller's
 speach synthesizer 
 */
@property (strong, nonatomic) AVSpeechSynthesizer *speechSynthesizer;

/**
 The view controller's
 recognized intents
 */
@property (strong, nonatomic) NSArray *recognizedIntents;

@end
