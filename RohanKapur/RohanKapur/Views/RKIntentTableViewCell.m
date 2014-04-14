//
//  RKIntentTableViewCell.m
//  RohanKapur
//
//  Created by Rohan Kapur on 7/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "RKIntentTableViewCell.h"

@implementation RKIntentTableViewCell
@synthesize iconImageView, titleLabel, descriptionTextView, disclosureIndicator;

- (void)awakeFromNib {
    
    [self.iconImageView.layer setCornerRadius:10.0f];
    [self.iconImageView.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
