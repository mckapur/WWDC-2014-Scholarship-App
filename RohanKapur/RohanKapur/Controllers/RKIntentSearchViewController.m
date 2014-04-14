//
//  RKIntentSearchViewController.m
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "RKIntentSearchViewController.h"

@interface NSArray (IntentFiltering)

- (NSArray *)intentsWithFilter:(IntentFilterTypes)filterType;

@end

@implementation NSArray (IntentFiltering)

- (NSArray *)intentsWithFilter:(IntentFilterTypes)filterType {
    
    NSMutableArray *retVal = [[NSMutableArray alloc] init];
    
    for (RKIntent *intent in self) {
        
        if (filterType == kIntentFilterTypeLowersOnly && !intent.subIntents.count) {
            
            [retVal addObject:intent];
        }
        else if (filterType == kIntentFilterTypeSupersOnly && intent.subIntents.count) {
            
            [retVal addObject:intent];
        }
    }
    
    return (NSArray *)retVal;
}

@end

@interface RKIntentSearchViewController ()

@property SystemSoundID audioStartedSystemSoundID;
@property SystemSoundID audioEndedSystemSoundID;

@end

@implementation RKIntentSearchViewController
@synthesize loadingShimmeringView, scrollView, intentDetailViewController, witMicButton, witTextField, statusTextView, speechSynthesizer, intentTableView, recognizedIntents;

#pragma mark - Audio

- (void)speakText:(NSString *)text {
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    [utterance setRate:0.3f];
    [utterance setVolume:1.0f];
    [utterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"]];

    [self.speechSynthesizer speakUtterance:utterance];
}

- (void)prepareAudio {

    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self speakText:@"Hello! I'm Riri, and I'm here to answer all your questions. My hearing has degenerated a bit while trapped in this mobile phone, so, talk loud and clear."];
    
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([[NSBundle mainBundle] URLForResource:[kAudioAudioStart componentsSeparatedByString:@"."][0] withExtension:[kAudioAudioStart componentsSeparatedByString:@"."][1]]), &_audioStartedSystemSoundID);
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([[NSBundle mainBundle] URLForResource:[kAudioAudioStop componentsSeparatedByString:@"."][0] withExtension:[kAudioAudioStop componentsSeparatedByString:@"."][1]]), &_audioEndedSystemSoundID);
}

- (void)playSystemSound:(SystemSoundID)systemSoundID {

    if (systemSoundID == self.audioStartedSystemSoundID)
        AudioServicesAddSystemSoundCompletion(systemSoundID, NULL, NULL, systemSoundCompleted, (__bridge_retained void *)self);
    AudioServicesPlaySystemSound(systemSoundID);
}

void systemSoundCompleted(SystemSoundID systemSoundId, void *data) {

    [[NSNotificationCenter defaultCenter] postNotificationName:kRiriStartedSystemSoundCompleted object:nil];
}

#pragma mark - RKManager

- (void)configureManager {
    
    [[RKManager sharedManager] setDelegate:self];
}

- (void)witDidStartListening {

    [self playSystemSound:self.audioStartedSystemSoundID];
 
    [self stopShimmerForFBShimmeringID:kFBShimmeringWitMic];
    [self stopShimmerForFBShimmeringID:kFBShimmeringCheatSheetLabel];

    [self setRecognizedIntents:@[]];
    [self reloadTableView];
}

- (void)witDidStopListening {
    
    [self playSystemSound:self.audioEndedSystemSoundID];
    
    [self toggleLoading:YES];
}

- (void)witErrorOccurred:(NSError *)error {

    [self setRecognizedIntents:@[]];
    
    [self reloadTableView];
    [self toggleLoading:NO];
    [self toggleError:error];
}

- (void)witRecognizedVoice:(NSString *)recognizedText withAssociatedIntents:(NSArray *)intents {

    [self.witTextField setText:recognizedText];
    
    [self witRecognizedExpressionWithAssociatedIntents:intents];
}

- (void)witRecognizedExpressionWithAssociatedIntents:(NSArray *)intents {

    [self setRecognizedIntents:intents];
    
    [self speakText:((RKIntent *)self.recognizedIntents[0]).shortDescription];
    
    if (intents.count == 1 && [intents intentsWithFilter:kIntentFilterTypeLowersOnly].count == 1 && ((RKIntent *)self.recognizedIntents[0]).detailView) {
        [self.intentDetailViewController setDetailView:((RKIntent *)self.recognizedIntents[0]).detailView];
        [self presentViewController:self.intentDetailViewController animated:YES completion:^{
        }];
    }

    [self toggleLoading:NO];
    [self reloadTableView];
}

- (void)toggleLoading:(BOOL)loading {
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:loading ? @"Loading" : @"" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Avenir-Book" size:78.0f], NSFontAttributeName, [UIColor lightGrayColor], NSForegroundColorAttributeName, nil, nil]];
    [self.statusTextView setAttributedText:attributedText];
    [self.statusTextView sizeToFit];

    [self.loadingShimmeringView setShimmering:loading];
}

- (void)toggleError:(NSError *)error {
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:!error.localizedDescription.length ? [NSString stringWithFormat:@"%@", error.domain] : error.localizedDescription attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Avenir-Book" size:25.0f], NSFontAttributeName, [UIColor lightGrayColor], NSForegroundColorAttributeName, nil, nil]];
    [self.statusTextView setAttributedText:attributedText];
    [self.statusTextView sizeToFit];
    
    [self speakText:@"I don't know how to reply to that, this is embarrassing."];
}

#pragma mark - Views

- (void)removeViewWithAccessibilityIdentifier:(NSString *)ID {
    
    for (UIView *subview in self.scrollView.subviews) {
        
        if ([subview.accessibilityIdentifier isEqualToString:ID])
            [subview removeFromSuperview];
    }
}

- (void)removeViewWithTag:(NSInteger)tag {
    
    for (UIView *subview in self.scrollView.subviews) {

        if (subview.tag == tag)
            [subview removeFromSuperview];
    }
}

- (void)stopShimmerForFBShimmeringID:(NSString *)ID {
    
    for (UIView *subview in self.scrollView.subviews) {
        
        if ([subview isKindOfClass:[FBShimmeringView class]] && [subview.accessibilityIdentifier isEqualToString:ID]) {
            
            [(FBShimmeringView *)subview setShimmering:NO];
        }
    }
}

- (FBShimmeringView *)shimmeringViewWithSpeed:(CGFloat)shimmeringSpeed direction:(FBShimmerDirection)direction accessibilityIdentifier:(NSString *)accessibilityIdentifier appliedView:(UIView *)view startShimmeringImmediately:(BOOL)startShimmeringImmediately {
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] init];
    [shimmeringView setFrame:view.frame];
    [shimmeringView setContentView:view];
    
    [shimmeringView setAccessibilityIdentifier:accessibilityIdentifier];
    
    [shimmeringView setShimmeringSpeed:shimmeringSpeed == -1 ? 230 : shimmeringSpeed];
    [shimmeringView setShimmeringDirection:direction];
    
    [shimmeringView setShimmering:startShimmeringImmediately];
    
    return shimmeringView;
}

#pragma mark Scroll View

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self stopShimmerForFBShimmeringID:kFBShimmeringCheatSheetLabel];
}

#pragma mark Table View

- (void)reloadTableView {
    
    [self removeViewWithAccessibilityIdentifier:kFBShimmeringCheatSheetLabel];
    [self removeViewWithTag:kCheatSheetLabelID];
    
    [self.intentTableView reloadData];
    [self.intentTableView setNeedsDisplay];
    
    [UIView animateWithDuration:1.0f animations:^{
        
        [self.intentTableView setAlpha:[self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly].count ? 1.0f : 0.0f];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [tableView.accessibilityIdentifier isEqualToString:kIntentTableView] ? [self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly].count : self.cheatSheetData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /**
     Some last minute problems
     with dequeing cells for the
     cheat sheet table view cell,
     decided to strip it.
     
     #Hacky
     
     - Good wishes from Rohan Kapur
     */
    
    UITableViewCell *cell;

    if ([tableView.accessibilityIdentifier isEqualToString:kIntentTableView]) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"RKIntentTableViewCell" owner:self options:nil];
        
        for (UIView *view in views) {
            
            if ([view isKindOfClass:[UITableViewCell class]]) {
                
                cell = (RKIntentTableViewCell *)view;
            }
        }
        
        [(RKIntentTableViewCell *)cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [((RKIntentTableViewCell *)cell).iconImageView setImage:[UIImage imageNamed:((RKIntent *)[self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly][indexPath.row]).logoPath]];
        [((RKIntentTableViewCell *)cell).titleLabel setText:((RKIntent *)[self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly][indexPath.row]).title];
        [((RKIntentTableViewCell *)cell).descriptionTextView setText:((RKIntent *)[self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly][indexPath.row]).shortDescription];
        
        [((RKIntentTableViewCell *)cell).titleLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:19.0f]];
        
        [((RKIntentTableViewCell *)cell).descriptionTextView setFont:[UIFont fontWithName:@"Avenir-Book" size:13.0f]];
        [((RKIntentTableViewCell *)cell).descriptionTextView setTextColor:[UIColor lightGrayColor]];
        [((RKIntentTableViewCell *)cell).descriptionTextView setEditable:NO];
        [((RKIntentTableViewCell *)cell).descriptionTextView setUserInteractionEnabled:NO];
        
        [((RKIntentTableViewCell *)cell).disclosureIndicator setFont:[UIFont fontWithName:@"Avenir-Heavy" size:17.0f]];
        [((RKIntentTableViewCell *)cell).disclosureIndicator setTextColor:[UIColor darkGrayColor]];
        [((RKIntentTableViewCell *)cell).disclosureIndicator setHidden:!((RKIntent *)[self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly][indexPath.row]).detailView ? YES : NO];
    }
    else {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCheatSheetCellIdentifier];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
        [cell.textLabel setNumberOfLines:3];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        
        [cell.textLabel setText:self.cheatSheetData[indexPath.row]];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return [tableView.accessibilityIdentifier isEqualToString:kIntentTableView] ? 89 : 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return [tableView.accessibilityIdentifier isEqualToString:kIntentTableView] ? 15 : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [footer setBackgroundColor:[UIColor clearColor]];
    
    return [tableView.accessibilityIdentifier isEqualToString:kIntentTableView] ? footer : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (((RKIntent *)[self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly][indexPath.row]).detailView && [tableView.accessibilityIdentifier isEqualToString:kIntentTableView]) {
    
        [self.intentDetailViewController setDetailView:((RKIntent *)[self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly][indexPath.row]).detailView];
        [self presentViewController:self.intentDetailViewController animated:YES completion:^{}];
    }
    
    [self speakText:((RKIntent *)[self.recognizedIntents intentsWithFilter:kIntentFilterTypeLowersOnly][indexPath.row]).shortDescription];
}

#pragma mark - Text Field

- (void)witTextFieldDidSearch:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    if (textField.text.length) {
        
        [self toggleLoading:YES];

        [self stopShimmerForFBShimmeringID:kFBShimmeringCheatSheetLabel];
        
        [self setRecognizedIntents:@[]];
        [self reloadTableView];

        [[RKManager sharedManager] queryWitForExpression:textField.text];
    }
}

#pragma mark Layout

- (void)layout {
    
    [self.view setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }];
        
    [self drawScrollView];
    
    [self drawHeader];
    [self drawBody];
}

- (void)drawScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setScrollsToTop:NO];
    [self.scrollView setBounces:NO];
    [self.scrollView setCanCancelContentTouches:NO];
    [self.scrollView setDelaysContentTouches:YES];
    [self.scrollView setDelegate:self];
    
    [self.scrollView setContentSize:CGSizeMake(640, self.view.frame.size.height)];
    
    [self.view addSubview:self.scrollView];
}

- (void)drawHeader {

    [self drawBlurredBanner];
    [self drawWitMic];
    [self drawWitTextField];
}

- (void)drawBody {
    
    [self drawCheatSheet];
    [self drawStatusTextView];

    [self drawTableView];
}

#pragma mark Header

- (void)drawWitMic {
    
    self.witMicButton = [[WITMicButton alloc] initWithFrame:CGRectMake(20, 27, 70, 70)];
    [self.witMicButton applyParallax];
    
    [UIView animateWithDuration:1.0f animations:^{

        [self.scrollView addSubview:self.witMicButton];
    }];
    
    [self.scrollView addSubview:[self shimmeringViewWithSpeed:75.0f direction:FBShimmerDirectionLeft accessibilityIdentifier:kFBShimmeringWitMic appliedView:self.witMicButton startShimmeringImmediately:YES]];
}

- (void)drawWitTextField {
    
    self.witTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 30, 320 - 130, 70)];

    [self.witTextField setFont:[UIFont fontWithName:@"Avenir-Book" size:17.5f]];
    [self.witTextField setPlaceholder:@"  or type in here..."];
    [self.witTextField setBackgroundColor:[UIColor clearColor]];
    [self.witTextField setBorderStyle:UITextBorderStyleNone];
    [self.witTextField setReturnKeyType:UIReturnKeySearch];
    [self.witTextField addTarget:self action:@selector(witTextFieldDidSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.witTextField setDelegate:self];
    
    [self.witTextField applyParallax];
    
    [self.scrollView addSubview:self.witTextField];
}

- (void)drawBlurredBanner {
    
    UIImageView *blurredBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 120)];
    [blurredBanner setImage:[UIImage imageNamed:kHeaderBlurredBannerImagePath]];
    [blurredBanner setAlpha:0.7f];
    
    [self.scrollView addSubview:blurredBanner];
}

#pragma mark Body

- (void)drawTableView {
    
    self.intentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 135, 320, [[UIScreen mainScreen] bounds].size.height - 125)];
    [self.intentTableView setAccessibilityIdentifier:kIntentTableView];
    
    [self.intentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.intentTableView setBackgroundView:nil];
    [self.intentTableView setBackgroundColor:[UIColor clearColor]];
    
    [self.intentTableView setDataSource:self];
    [self.intentTableView setDelegate:self];
    
    [self.intentTableView setAlpha:0.0f];
    
    [self.scrollView addSubview:self.intentTableView];
}

- (void)drawStatusTextView {
    
    self.statusTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, (self.view.frame.size.height - 300) / 2, 300, 0)];
    
    [self.statusTextView setBackgroundColor:[UIColor clearColor]];
    [self.statusTextView setEditable:NO];
    [self.statusTextView setUserInteractionEnabled:NO];
    [self.statusTextView setCanCancelContentTouches:NO];
    [self.statusTextView setDelaysContentTouches:NO];
    
    [self.statusTextView setAlpha:0.0f];
    
    [self cueIntroduction];
    
    [self.scrollView addSubview:self.statusTextView];
    
    [self drawStatusShimmeringLayer];
}

- (void)drawStatusShimmeringLayer {
    
    self.loadingShimmeringView = [self shimmeringViewWithSpeed:-1 direction:FBShimmerDirectionRight accessibilityIdentifier:nil appliedView:self.statusTextView startShimmeringImmediately:NO];
    [self.scrollView addSubview:self.loadingShimmeringView];
}

- (void)cueIntroduction {
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Meet Riri." attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f], NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil, nil]];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\r\rRiri is a clone of Rohan Kapur trapped in a robotic voice assistant.\r\rTap the microphone above, and ask a question, or search for something.\r\rMake sure: device not on silent, volume turned up, good internet connection" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Avenir-Book" size:17.5f], NSFontAttributeName, [UIColor grayColor], NSForegroundColorAttributeName, nil, nil]]];
    if ([[UIScreen mainScreen] bounds].size.height > 500) [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\r\rOkay, go have fun!" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Avenir-Book" size:17.5f], NSFontAttributeName, [UIColor grayColor], NSForegroundColorAttributeName, nil, nil]]];

    
    [self.statusTextView setAttributedText:attributedText];
    
    [self.statusTextView sizeToFit];
    
    [UIView animateWithDuration:3.0f animations:^{
        
        [self.statusTextView setAlpha:1.0f];
    }];
}

- (void)drawCheatSheet {
    
    [self drawCheatSheetLabel];
    [self drawCheatSheetHeader];
    [self drawCheatSheetBody];
}

- (void)drawCheatSheetLabel {

    UILabel *cheatSheetLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - 160, [[UIScreen mainScreen] bounds].size.height - 80, 320, 100)];
    [cheatSheetLabel setFont:[UIFont fontWithName:@"Avenir-Book" size:15.0f]];
    [cheatSheetLabel setTextAlignment:NSTextAlignmentCenter];
    [cheatSheetLabel setTextColor:[UIColor grayColor]];
    [cheatSheetLabel setNumberOfLines:2];
    [cheatSheetLabel setText:@"Cheat Sheet >"];
    [cheatSheetLabel setTag:kCheatSheetLabelID];
    [cheatSheetLabel setUserInteractionEnabled:NO];

    [cheatSheetLabel applyParallax];
    
    [self.scrollView addSubview:cheatSheetLabel];
    [self.scrollView addSubview:[self shimmeringViewWithSpeed:150.0f direction:FBShimmerDirectionLeft accessibilityIdentifier:kFBShimmeringCheatSheetLabel appliedView:cheatSheetLabel startShimmeringImmediately:YES]];
}

- (void)drawCheatSheetHeader {
    
    UILabel *cheatSheetHeader = [[UILabel alloc] initWithFrame:CGRectMake(340, 50, 300, 50)];
    [cheatSheetHeader setFont:[UIFont fontWithName:@"Avenir-Book" size:14.0f]];
    [cheatSheetHeader setTextColor:[UIColor lightGrayColor]];
    [cheatSheetHeader setText:@"These are some things you can ask me about. Ask and talk in any way you like, I'm using natural language processing on the back."];
    [cheatSheetHeader setNumberOfLines:3];
    [cheatSheetHeader sizeToFit];
    
    [self.scrollView addSubview:cheatSheetHeader];
    
    [cheatSheetHeader applyParallax];
}

- (void)drawCheatSheetBody {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(320, 130, 320, [[UIScreen mainScreen] bounds].size.height - 130)];
    [tableView setAccessibilityIdentifier:kCheatSheetTableView];
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [tableView setBackgroundView:nil];
    [tableView setBackgroundColor:[UIColor clearColor]];
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [self.scrollView addSubview:tableView];
}

- (void)assembleCheatSheetData {
    
    self.cheatSheetData = @[@"math, science, english, general knowledge",  @"why I want to attend WWDC", @"about me (name, age, contact, born, live, from, family, religion)", @"projects (apps, hacks, work)", @"school and educational background", @"hobbies (programming, music, tv)", @"techical skills (languages I can write)", @"my love and passion for apple", @"life achievements and awards", @"aspirations - what I want to be in the future", @"why I make apps and what motivates me", @"how I first became a developer", @"a special video just for the judges :O", @"a lot of other stuff I'll let you figure out!"];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [self assembleCheatSheetData];
    [self prepareAudio];
    [self layout];
    [self configureManager];
    
    self.intentDetailViewController = [[RKIntentDetailViewController alloc] init];

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end