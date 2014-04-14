//
//  RKIntentDetailViewController.m
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "RKIntentDetailViewController.h"

@interface RKIntentDetailViewController ()

@end

@implementation RKIntentDetailViewController
@synthesize dismissButton, detailView;

- (void)dismissDetailViewController {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.detailView removeFromSuperview];
        self.detailView = nil;
    }];
}

#pragma mark - Views

- (void)drawDismissButton {
    
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.dismissButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Book" size:25.0f]];
    [self.dismissButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.dismissButton setTitle:@"x" forState:UIControlStateNormal];
    
    [self.dismissButton sizeToFit];
    [self.dismissButton setCenter:CGPointMake(30, 40)];
    
    [self.dismissButton addTarget:self action:@selector(dismissDetailViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.dismissButton];
}

#pragma mark - View Lifecycle

- (void)viewDidAppear:(BOOL)animated {
    
    [self.view bringSubviewToFront:self.dismissButton];

    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.view addSubview:self.detailView];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    
    [self drawDismissButton];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
