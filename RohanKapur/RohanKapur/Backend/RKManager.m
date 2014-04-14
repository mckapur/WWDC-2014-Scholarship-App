//
//  RKManager.m
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "RKManager.h"

@interface NSArray (IntentSearching)

- (BOOL)containsIntent:(RKIntent *)intent;

@end

@implementation NSArray (IntentSearching)

- (BOOL)containsIntent:(RKIntent *)intent {
    
    BOOL retVal = NO;
    
    for (RKIntent *_intent in self) {
        
        if ([intent.ID isEqualToString:_intent.ID]) {
            
            retVal = YES;
        }
    }
    
    return retVal;
}

@end

@interface NSString (URLRequestFormatting)

- (NSString *)urlEncode;

@end

@implementation NSString (URLRequestFormatting)

- (NSString *)urlEncode {
    
    NSMutableString *output = [NSMutableString string];
    
    const unsigned char *source = (const unsigned char *)[self UTF8String];

    for (int i = 0; i < strlen((const char *)source); ++i) {
        
        const unsigned char thisChar = source[i];
        
        if (thisChar == ' ')
            [output appendString:@"+"];
        else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9'))
            [output appendFormat:@"%c", thisChar];
        else
            [output appendFormat:@"%%%02X", thisChar];
    }

    return output;
}

@end

@implementation RKManager
@synthesize delegate;

#pragma mark - Wit

- (void)witDidGraspIntent:(NSString *)intent confidence:(NSString *)confidence entities:(NSDictionary *)entities body:(NSString *)body error:(NSError *)error {

    if (error || !intent.length || [confidence floatValue] <= 0.45) {
        
        if (body.length) {
    
            [self queryWolframAlphaForExpression:body withCompletionHandler:^(NSError *wolframError, NSArray *intents) {

                if (wolframError)
                    [self.delegate witErrorOccurred:error ? error : wolframError];
                else
                    if (entities[@"textQuery"])
                        [self.delegate witRecognizedExpressionWithAssociatedIntents:intents];
                    else
                        [self.delegate witRecognizedVoice:body withAssociatedIntents:intents];
            }];
        }
        else {
            
            [self.delegate witErrorOccurred:error];
        }
    }
    else {
        
        [self orderIntentsFromIDs:@[intent] withCompletionHandler:^(NSError *error, NSArray *intents) {

            if (error) {
                
                [self.delegate witErrorOccurred:error];
            }
            else {
                
                [self orderSingleSuperIntentWithID:intent withCompletionHandler:^(NSError *error, RKIntent *intent) {
                    
                    if (error) {
                        
                        [self.delegate witErrorOccurred:error];
                    }
                    else {
                        
                        if (!intents.count)
                            [self.delegate witErrorOccurred:[NSError errorWithDomain:kErrorDomainIntentNotRecognized code:kErrorCodesIntentNotRecognized userInfo:@{NSLocalizedDescriptionKey: kErrorDescriptionIntentNotRecognized}]];
                        else {
                            
                            if (entities[@"textQuery"])
                                [self.delegate witRecognizedExpressionWithAssociatedIntents:[intents containsIntent:intent] ? intents : [@[intent] arrayByAddingObjectsFromArray:intents]];
                            else
                                [self.delegate witRecognizedVoice:body withAssociatedIntents:[intents containsIntent:intent] ? intents : [@[intent] arrayByAddingObjectsFromArray:intents]];
                        }
                    }
                }];
            }
        }];
    }
}

- (void)queryWitForExpression:(NSString *)expression {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@", kWitExpressionQueryEndpoint, [[expression lowercaseString] urlEncode]]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15.0];
    [request setHTTPMethod:@"GET"];

    [request setValue:[NSString stringWithFormat:@"Bearer %@", [[Wit sharedInstance] accessToken]] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *URLResponse, NSData *data, NSError *connectionError) {
        
        NSError *error = connectionError;
        
        NSError *serializationError;
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];

        if (!data || !response)
            error = [NSError errorWithDomain:@"WitProcessing" code:[response[kWitResponseKeyError][@"code"] intValue] userInfo:@{NSLocalizedDescriptionKey: response[kWitResponseKeyError][@"message"]}];
        
        if (!error) {
            
            if (!serializationError) {
                
                if (response[kWitResponseKeyError]) {
                    
                    error = [NSError errorWithDomain:@"WitProcessing" code:[response[kWitResponseKeyError][@"code"] intValue] userInfo:@{NSLocalizedDescriptionKey: response[kWitResponseKeyError][@"message"]}];
                }
                else {
                    
                    if (!response[kWitResponseKeyOutcome] || !response[kWitResponseKeyOutcome][@"intent"] || [response[kWitResponseKeyOutcome][@"intent"] isEqual:[NSNull null]]) error = [NSError errorWithDomain:@"WitProcessing" code:1 userInfo:@{NSLocalizedDescriptionKey: kErrorDescriptionIntentNotFound}];
                }
            }
        }
        
        [self witDidGraspIntent:response[kWitResponseKeyOutcome][@"intent"] confidence:response[kWitResponseKeyOutcome][@"confidence"] entities:@{@"textQuery": @"YES"} body:expression error:error];
    }];
}

- (void)witAudioDidStart {
    
    [self.delegate witDidStartListening];
}

- (void)witAudioDidStop {
    
    [self.delegate witDidStopListening];
}

#pragma mark - Wolfram Alpha

- (void)queryWolframAlphaForExpression:(NSString *)expression withCompletionHandler:(void (^)(NSError *error, NSArray *intents))callback {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?input=%@&appid=%@", kWolframAlphaQueryEndpoint, [expression urlEncode], kWolframAlphaQueryAppID]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15.0];
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSError *error = connectionError;
        if (!response || !data || ![NSDictionary dictionaryWithXMLData:data].count) error = [NSError errorWithDomain:@"WolframAlphaProcessing" code:kErrorCodesIntentNotFound userInfo:@{NSLocalizedDescriptionKey: kErrorDescriptionIntentNotFound}];
        if ([[NSDictionary dictionaryWithXMLData:data][@"_error"] isEqualToString:@"true"]) error = [NSError errorWithDomain:@"WolframAlphaProcessing" code:[[NSDictionary dictionaryWithXMLData:data][@"error"][@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey: [NSDictionary dictionaryWithXMLData:data][@"error"][@"msg"]}];
        
        RKIntent *intent;
        
        if (!error) {
            
            NSString *input = [NSDictionary dictionaryWithXMLData:data][@"pod"][0][@"subpod"][@"plaintext"];
            NSString *result = [NSDictionary dictionaryWithXMLData:data][@"pod"][1][@"subpod"][@"plaintext"];
            
            if (!input || !result)
                error = [NSError errorWithDomain:@"WolframAlphaProcessing" code:kErrorCodesIntentNotRecognized userInfo:@{NSLocalizedDescriptionKey: kErrorDescriptionIntentNotRecognized}];
            else
                intent = [[RKIntent alloc] initWithID:input title:input intentType:kIntentTypeWolframAlpha subIntents:@[] detailView:nil logoPath:@"wolfram_alpha.jpg" description:[NSString stringWithFormat:@"I thought for a bit, the answer is: %@", result]];
        }

        callback(error, !intent ? @[] : @[intent]);
    }];
}

#pragma mark - Intent Searching

- (void)orderSingleSuperIntentWithID:(NSString *)ID withCompletionHandler:(void (^)(NSError *error, RKIntent *intent))callback {
    
    [[RKDataStore sharedIntentStore] readIntentsForIDs:@[ID] withCompletionHandler:^(NSError *error, NSArray *intents) {
       
        callback(error, intents[0]);
    }];
}

- (void)orderIntentsFromIDs:(NSArray *)IDs withCompletionHandler:(void (^)(NSError *error, NSArray *intents))callback {

    [[RKDataStore sharedIntentStore] readIntentsForIDs:IDs withCompletionHandler:^(NSError *error, NSArray *superIntents) {

        if (!error) {

            NSMutableArray *preLowerIntents = [[NSMutableArray alloc] init];
            NSMutableArray *preSuperIntents = [[NSMutableArray alloc] init];

            for (RKIntent *intent in superIntents) {

                if (intent.subIntents.count)
                    [preSuperIntents addObjectsFromArray:intent.subIntents];
                else
                    [preLowerIntents addObject:intent];
            }

            if (preSuperIntents.count) {
                
                [self orderIntentsFromIDs:preSuperIntents withCompletionHandler:^(NSError *error, NSArray *lowerIntents) {
                
                    callback(error, !error ? [preLowerIntents arrayByAddingObjectsFromArray:lowerIntents] : nil);
                }];
            }
            else {
                
                callback(error, !error ? superIntents : nil);
            }
        }
        else {
          
            callback(error, nil);
        }
    }];
}

#pragma mark - Initialization


+ (RKManager *)sharedManager {
    
    static RKManager *sharedManager;
    
    @synchronized (self) {
        
        if (!sharedManager)
            sharedManager = [[RKManager alloc] init];
        
        return sharedManager;
    }
}

- (id)init {
    
    if (self = [super init]) {
                
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(witAudioDidStart) name:kWitNotificationAudioStart object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(witAudioDidStop) name:kWitNotificationAudioEnd object:nil];
        
        [[Wit sharedInstance] setAccessToken:kWitAccessToken];
        [[Wit sharedInstance] setDelegate:self];
        
        [RKIntentAssembly assembleIntents];
    }
    
    return self;
}

@end
