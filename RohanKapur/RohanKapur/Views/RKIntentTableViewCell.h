//
//  RKIntentTableViewCell.h
//  RohanKapur
//
//  Created by Rohan Kapur on 7/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

/**
 An intent table view
 cell for the RKIntentSearch-
 ViewController's table view
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RKIntentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *disclosureIndicator;

@end
