//
//  UIView+Styles.m
//  RohanKapur
//
//  Created by Rohan Kapur on 7/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "UIView+Styles.h"

@implementation UIView (Styles)

- (void)applyParallax {
    
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    [verticalMotionEffect setMinimumRelativeValue:@(-15)];
    [verticalMotionEffect setMaximumRelativeValue:@(15)];
    
    UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    [horizontalMotionEffect setMinimumRelativeValue:@(-15)];
    [horizontalMotionEffect setMaximumRelativeValue:@(15)];
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    [group setMotionEffects:@[horizontalMotionEffect, verticalMotionEffect]];
    
    [self addMotionEffect:group];
}

@end
