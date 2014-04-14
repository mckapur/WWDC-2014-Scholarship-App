//
//  RKIntent.h
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 RKIntent, represents the user's
 query intention, deduced by natural language
 search processing http://wit.ai
 */

@interface RKIntent : NSObject <NSCoding>

/**
 The intent's name-base ID
 */
@property (readonly, nonatomic) NSString *ID;

/**
 The intent's title
 */
@property (readonly, nonatomic) NSString *title;

/**
 The intent type
 */
@property (readonly, nonatomic) NSInteger intentType;

/**
 The intent's expandeded sub- intents,
 eg. "age", "name", "family" for "about"
 */
@property (readonly, nonatomic) NSArray *subIntents;

/**
 The intent's expanded detail view
 */
@property (readonly, nonatomic) id detailView;

/**
 The intent's logo path
 */
@property (readonly, nonatomic) NSString *logoPath;

/**
 The intent's short description,
 used to synthesize into speech
 */
@property (readonly, nonatomic) NSString *shortDescription;

- (id)initWithID:(NSString *)_ID title:(NSString *)_title intentType:(NSInteger)_intentType subIntents:(NSArray *)_subIntents detailView:(UIView *)_detailView logoPath:(NSString *)_logoPath description:(NSString *)_description;

@end
