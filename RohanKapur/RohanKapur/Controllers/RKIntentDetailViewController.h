//
//  RKIntentDetailViewController.h
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 RKIntentDetailViewController
 displays the 'detailView'
 property of an intent
 */

static __unused NSString* const kDismissButtonImagePath = @"dismissButton.jpg";

@interface RKIntentDetailViewController : UIViewController

/**
 The detail view
 */
@property (strong, nonatomic) UIView *detailView;

/**
 The dismiss button
 */
@property (strong, nonatomic) UIButton *dismissButton;

@end
