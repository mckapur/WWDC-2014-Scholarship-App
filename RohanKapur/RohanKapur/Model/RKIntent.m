//
//  RKIntent.m
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "RKIntent.h"

@implementation RKIntent
@synthesize ID, title, intentType,  subIntents, detailView, logoPath, shortDescription;

- (NSString *)description {
    
    return [NSString stringWithFormat:@"ID: %@ - Title: %@ - Sub Intents: %@ - Intent Type: %li - Logo Path: %@ - Short Description: %@", self.ID, self.title, self.subIntents, (long)self.intentType, self.logoPath, self.shortDescription];
}

#pragma mark - RO Getters

- (void)setID:(NSString *)_ID {
    
    ID = _ID;
}

- (void)setTitle:(NSString *)_title {
    
    title = _title;
}

- (void)setIntentType:(NSInteger)_intentType {
    
    intentType = _intentType;
}

- (void)setSubIntents:(NSArray *)_subIntents {
    
    subIntents = _subIntents;
}

- (void)setDetailView:(UIView *)_detailView {
    
    detailView = _detailView;
}

- (void)setLogoPath:(NSString *)_logoPath {
    
    logoPath = _logoPath;
}

- (void)setShortDescription:(NSString *)_description {
    
    shortDescription = _description;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.intentType forKey:@"intentType"];
    [aCoder encodeObject:self.subIntents forKey:@"subIntents"];
    [aCoder encodeObject:self.logoPath forKey:@"logoPath"];
    [aCoder encodeObject:self.shortDescription forKey:@"description"];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.detailView forKey:@"view"];
    [archiver finishEncoding];
    
    [data writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"View_%@", self.ID]] atomically:YES];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [self init]) {
        
        [self setID:[aDecoder decodeObjectForKey:@"ID"]];
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setIntentType:[aDecoder decodeIntegerForKey:@"intentType"]];
        [self setSubIntents:[aDecoder decodeObjectForKey:@"subIntents"]];
        [self setLogoPath:[aDecoder decodeObjectForKey:@"logoPath"]];
        [self setShortDescription:[aDecoder decodeObjectForKey:@"description"]];
        
        NSData *detailViewData = [[NSData alloc] initWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"View_%@", self.ID]]];
        NSKeyedUnarchiver  *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:detailViewData];
        [self setDetailView:[unarchiver decodeObjectForKey:@"view"]];
        [unarchiver finishDecoding];
    }
    
    return self;
}

#pragma mark - Initiaization

- (id)initWithID:(NSString *)_ID title:(NSString *)_title intentType:(NSInteger)_intentType subIntents:(NSArray *)_subIntents detailView:(UIView *)_detailView logoPath:(NSString *)_logoPath description:(NSString *)_description {
    
    if (self = [self init]) {
        
        [self setID:_ID];
        [self setTitle:_title];
        [self setIntentType:_intentType];
        [self setSubIntents:_subIntents];
        [self setDetailView:_detailView];
        [self setLogoPath:_logoPath];
        [self setShortDescription:_description];
    }
    
    return self;
}

- (id)init {
    
    return self = [super init];
}

@end
