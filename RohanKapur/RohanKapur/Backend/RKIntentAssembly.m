//
//  RKIntentFactory.m
//  Rohan Kapur
//
//  Created by Rohan Kapur on 5/4/14.
//  Copyright (c) 2014 Rohan Kapur. All rights reserved.
//

#import "RKIntentAssembly.h"

@implementation RKIntentAssembly

#pragma mark - Intent Construction

+ (void)assembleIntents {
    
    NSMutableArray *intents = [[NSMutableArray alloc] init];
    
    /* About */
    
    [intents addObject:[self intentWithID:@"name" title:@"My name" subIntents:@[] detailView:nil description:@"My name is Rohan Kapur, I don't have a middle name :("]];
    [intents addObject:[self intentWithID:@"age" title:@"How old I am" subIntents:@[] detailView:nil description:@"I am 15 years old, born 18th February 1999"]];
    [intents addObject:[self intentWithID:@"contact" title:@"Contact me" subIntents:@[] detailView:[self constructWebViewWithContent:@{kContentURL: kPersonalWebsiteURL} withFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height)] description:@"Visit www.rohankapur.com for how you can contact me"]];
    [intents addObject:[self intentWithID:@"family" title:@"My family" subIntents:@[] detailView:nil description:@"I live with a mom, a dad, and a younger brother"]];
    [intents addObject:[self intentWithID:@"born" title:@"Where I was born" subIntents:@[] detailView:nil description:@"I was born in Melbourne, Victoria, Australia"]];
    [intents addObject:[self intentWithID:@"live" title:@"Where I live" subIntents:@[] detailView:nil description:@"I currently live in Singapore, Singapore"]];
    [intents addObject:[self intentWithID:@"from" title:@"Where I'm from" subIntents:@[] detailView:nil description:@"My parents are originally from India"]];
    [intents addObject:[self intentWithID:@"religion" title:@"My religion" subIntents:@[] detailView:nil description:@"I'm unsure of my religion, maybe Atheist?"]];
    [intents addObject:[self intentWithID:@"about" title:nil subIntents:@[@"name", @"age", @"contact", @"family", @"born", @"live", @"from", @"religion"] detailView:nil description:@"15. iOS & Web developer. WWDC 2013 Scholarship Recipient"]];
    
    /* Apple */
    
    [intents addObject:[self intentWithID:@"apple" title:@"Love for Apple" subIntents:@[] detailView:[self constructInfoViewWithContent:@{kContentIcon: @"apple.jpg", kContentTitle: @"Love for Apple", kContentBody: @"When I was 7, and living in Melbourne, I went out to for a trip to the beloved Apple Store. I picked up a silver iPod Nano, 2nd generation. I fell in love, and my interest in Apple and their products grew. When I moved to Singapore, I started to help jailbreak friends' phones, (obviously not anymore). While browsing the Mac App Store, I found an app called 'Xcode', immediate reaction: \"I can download this right now and develop apps!?\". And it all started from there, I stay up at night for each Apple event, and watching it live at San Francisco last WWDC was an immense pleasure. Apple is my life."}] description:@"Since I was 7, Apple has been a huge part of my life"]];
    
    /* Apps */
    
    [intents addObject:[self intentWithID:@"travelog" title:@"Travelog" subIntents:@[] detailView:[self constructDetailViewFromAppTemplate:@{kContentIcon: @"travelog.jpg", kContentTitle: @"Travelog", kContentBody: @"Travelog is a powerful travel app that aims to ease the lives of frequent business travellers across the world. It consolidates useful information like news, weather, translations, currency, timezone differences, plug sizes places of interest, etc. in just a second! That's great, but Travelog also allows you to check out who will be in your city when you land, based on the connections you've made in-app. Currently, \"Trvlogue\", is on the App Store, but an update consisting of this release is waiting for review! Visit www.travelogapp.com for more info. Swipe left to view screenshots >", kContentScreenshots: @[@"screenshots_travelog1.jpg", @"screenshots_travelog2.jpg", @"screenshots_travelog3.jpg", @"screenshots_travelog4.jpg", @"screenshots_travelog5.jpg"]}] description:@"Travelog, a powerful app that eases the lives of travellers"]];
    [intents addObject:[self intentWithID:@"parknav" title:@"Parknav" subIntents:@[] detailView:[self constructDetailViewFromAppTemplate:@{kContentIcon: @"parknav.jpg", kContentTitle: @"Parknav", kContentBody: @"Parknav is an app I developed for a client, it allows you to view available parking spots around you. It shows a diverse range of parking spaces (malls, centers, shops, onroad, etc.) which includes opening time, closing time, the cost, and more. The most compelling feature is that the is completely real-time, allowing you to use the app on-the-go, and get reliable, accurate information on where to park your car. It is currently only available in Dublin, Ireland. Swipe left to view screenshots >", kContentScreenshots: @[@"screenshots_parknav1.jpg", @"screenshots_parknav2.jpg", @"screenshots_parknav3.jpg"]}] description:@"Parknav, a great tool to find real-time parking spots in Dublin"]];
    [intents addObject:[self intentWithID:@"icab2go" title:@"iCab2Go" subIntents:@[] detailView:[self constructDetailViewFromAppTemplate:@{kContentIcon: @"icab2go.jpg", kContentTitle: @"iCab2Go", kContentBody: @"iCab2Go is a taxi app that I helped develop for a client, it connects people to taxis, making it easy to book a cab at any time of day. It is only available in Brazil. Swipe left for screenshots >", kContentScreenshots: @[@"screenshots_icab2go1.jpg", @"screenshots_icab2go2.jpg", @"screenshots_icab2go3.jpg"]}] description:@"iCab2Go is a taxi app for Brazil that I helped develop for a client"]];
    [intents addObject:[self intentWithID:@"ib" title:@"IB AP Conference 2012" subIntents:@[] detailView:[self constructDetailViewFromAppTemplate:@{kContentIcon: @"ib.jpg", kContentTitle: @"IB AP Conference 2012", kContentBody: @"IB AP Conference 2012 was one of the first apps I made ever. I was asked to develop an iPhone app that could display the speakers, map, news and schedule for the International Baccalaureate's conference back in early 2012, held in Singapore, where I live. As a reward for my efforts, the vice-president of IB in Asia Pacific issued me a certificate of appreciation. Swipe left for screenshots >", kContentScreenshots: @[@"screenshots_ib1.jpg", @"screenshots_ib2.jpg", @"screenshots_ib3.jpg"]}] description:@"This app is a guide for  attendees of the IB AP Conference 2012"]];
    [intents addObject:[self intentWithID:@"apps" title:nil subIntents:@[@"travelog", @"parknav", @"icab2go", @"ib"] detailView:nil description:@"I have built or am building a few different apps"]];

    /* Aspiration */
    
    [intents addObject:[self intentWithID:@"aspiration" title:@"My Aspirations" subIntents:@[] detailView:[self constructInfoViewWithContent:@{kContentIcon: @"aspiration.jpg", kContentTitle: @"My Aspirations", kContentBody: @"What do I wanna be when I grow up? Not sure. It's a scary question. I want to graduate from Stanford, that's my dream school. I would love to to be at Apple, it's a company that I respect, and whose product's I admire. What I'm doing right now, is almost walking a purposeful path to be with Apple. But I love being a developer. Solving problems through apps that people can download and use daily is rewarding. Writing code is fun. On top of this, I couldn't imagine not being completely in charge of my own work. So alternatively, I would also love to head my own app/services company. But ya know, it all comes in time."}] description:@"Maybe I wanna work at Apple, maybe I wanna start up my own app firm. Not sure."]];
    
    /* Awards */
    
    [intents addObject:[self intentWithID:@"awards" title:@"My Awards" subIntents:@[] detailView:[self constructInfoViewWithContent:@{kContentIcon: @"awards.jpg", kContentTitle: @"My Awards", kContentBody: @"Before I begin - my greatest achievement of all - is the bronze iOS badge on StackOverflow, and a 4500 rep! Just kidding. First and foremost, I won a scholarship to attend WWDC 2013. I wanted it so bad, as I was rejected the year before. And man, when I got the congratulatory email, that was the most thrilling moment of my life - it made me nauseous and overjoyed at the same time. WWDC 2013 was the best event I've ever been to, I met great people, learnt new things, and San Francisco is wondrous. It was a blast. Seriously. I need to go again! (Seriously I need to go again). In March of 2012, the IB (International International Baccalaureate) held a conference in Singapore, featuring talks from infleuntial speakers such as Hans Rosling, Kiran Bedi, etc. I was approached to develop them an app, my first legit project after I started learning the June before. I spent countless hours on it, till eventually I submitted to the App Store. It was rejected. That was scary. However I fought to get it expedited and released the morning of the conference! The IB chair vice-president awarded me with a certificate of appreciation, which still sits by my desk."}] description:@"I have won two awards, in total, one more awesome than the other"]];
    
    /* Curse */
    
    [intents addObject:[self intentWithID:@"curse" title:@"You swore!" subIntents:@[] detailView:nil description:@"OMG you swore, I'm telling on you"]];
    
    /* Food */
    
    [intents addObject:[self intentWithID:@"food" title:@"Food" subIntents:@[] detailView:nil description:@"I love food. Food is the universe. Ok bye."]];
    
    /* How */
    
    [intents addObject:[self intentWithID:@"how" title:@"How It Began" subIntents:@[] detailView:[self constructInfoViewWithContent:@{kContentIcon: @"how.jpg", kContentTitle: @"How It Began", kContentBody: @"It all started when I was a young Apple fanboy. But you can get more into by asking me about my love for apple. One day, while browsing through the Mac App Store, I noticed an app called \"Xcode\". The icon looked neat, so I opened it up (I judge books by their covers). I read the description, and screamed with joy: \"I can use this to make iOS apps!?\". So I bought it for 5 bucks, opened it up, and then realized I had just wasted 5 bucks on something I didn't know how to use. So I visited YouTube, I learnt from someone who sounded 12 how to create my first \"Hello World\" app. I then continued to read an Objective-C book, and explored different APIs and SDKs whilst developing practice apps. I scoured forums and sites like StackOverflow (where I now help many others) for answers, and ended up asking my own questions. I became independant, I taught myself how to apply my knowledge and logic, and here I am now. I've made a couple problem-solving apps, earned a couple bucks, and attended WWDC on scholarship. I owe it all to you guys at Apple, thanks a bunch."}] description:@"In the bright June of 2011, a coder was born"]];
    
    /* Hacks */
    
    [intents addObject:[self intentWithID:@"thisisawkward" title:@"This Is Awkward" subIntents:@[] detailView:[self constructDetailViewFromWebsiteTemplate:@{kContentIcon: @"thisisawkward.jpg", kContentTitle: @"This Is Awkward", kContentBody: @"This Is Awkward is a little hack I developed using the Twilio API that allows you to send voice messages (automated phone calls) to anyone across the world. You customize the sender, recipient phone number, and the message body. The other person will receive a phone call, and pick up to a completely voice synthesized message! It's pretty funny. The whole idea behind it is a joke, it was just me having fun using the Twilio API. It's cool talking about it, it's another thing to see it in action >", kContentURL: kThisIsAwkwardURL}] description:@"A little hack that lets you automate phone calls to people"]];
    [intents addObject:[self intentWithID:@"leapduino" title:@"LeapDuino" subIntents:@[] detailView:[self constructDetailViewFromWebsiteTemplate:@{kContentIcon: @"leapduino.jpg", kContentTitle: @"LeapDuino", kContentBody: @"The Leap Motion is a device that records the movement of your hands. LeapDuino is a little hack I made that uses input from the Leap Motion to control the movement of two servos connected to an Arduino board. It is written in JavaScript. I can connect two servos, and make it so vertical hand movement controls one servos, and horizontal movement controls another servos mounted on it. Words words words. Swipe left for a video >", kContentURL: kLeapDuinoURL}] description:@"A little hack that lets you move a servo using Leap Motion an Arduino"]];
    [intents addObject:[self intentWithID:@"hacks" title:nil subIntents:@[@"leapduino", @"thisisawkward"] detailView:nil description:@"When I'm bored, I make random stuff with cool APIs"]];
    
    /* Hello */
    
    [intents addObject:[self intentWithID:@"hello" title:@"Hi!" subIntents:@[] detailView:nil description:@"Riri says hi back! Also, turn around, I'm right behind you."]];
    
    /* Highlights */
    
    [intents addObject:[self intentWithID:@"highlights" title:@"Highlights of My Life" subIntents:@[] detailView:[self constructInfoViewWithContent:@{kContentIcon: @"highlights.jpg", kContentTitle: @"Highlights of My Life", kContentBody: @"My life's had it's ups and downs. I'm a generally happy person. But what are the highlights of my life? Well, I can easily categorize the best days of my life all under development or music. Watching Green Day live when I was 10 - a winner. Watching Youth Lagoon live this year - a winner too. Getting my first app on the App Store, wow, that was just breathtaking. Then being paid the first time, for doing something I love (developing for clients). But oh my god, when I won the scholarship to attend WWDC 2013, that tops the charts. Let's then not forget #1, the WWDC keynote, or the entire event as a matter of fact. Meeting great people, seeing new products being unveiled right in front of me, hanging out in San Francisco, and learning new things at sessions and labs. And of course, meeting Craig Fedirighi #HairForceOne"}] description:@"My life's highest points are all about development"]];
    
    /* Music */
    
    [intents addObject:[self intentWithID:@"guitar" title:@"Playing Guitar" subIntents:@[] detailView:nil description:@"I've played acoustic and electric guitar for 4 years now"]];
    [intents addObject:[self intentWithID:@"piano" title:@"Playing Piano" subIntents:@[] detailView:nil description:@"I've played the piano for almost 8 years, that's a long time, but I did take a break in between."]];
    [intents addObject:[self intentWithID:@"vampireweekend" title:@"Listening to Vampire Weekend" subIntents:@[] detailView:nil description:@"Vampire Weekend is my favorite band, Step is my favorite song"]];
    [intents addObject:[self intentWithID:@"youthlagoon" title:@"Listening to Youth Lagoon" subIntents:@[] detailView:nil description:@"I also love listening Youth Lagoon, my second favorite song is Dropla"]];
    [intents addObject:[self intentWithID:@"music" title:nil subIntents:@[@"guitar", @"piano", @"vampireweekend", @"youthlagoon"] detailView:nil description:@"I play guitar and piano, I love Vampire Weekend and Youth Lagoon"]];
    
    /* Languages */
    
    [intents addObject:[self intentWithID:@"objectivec" title:@"Writing Objective-C" subIntents:@[] detailView:nil description:@"I write Objective-C to develop my iOS apps, it's fun"]];
    [intents addObject:[self intentWithID:@"javascript" title:@"Writing JavaScript" subIntents:@[] detailView:nil description:@"I also write JavaScript, for client and backend side (NodeJS)"]];
    [intents addObject:[self intentWithID:@"html" title:@"Writing HTML" subIntents:@[] detailView:nil description:@"I also do web design, thus HTML is a necessity"]];
    [intents addObject:[self intentWithID:@"css" title:@"Writing CSS" subIntents:@[] detailView:nil description:@"Again, I do web design, gotta pretty up that HTML, am I right"]];
    [intents addObject:[self intentWithID:@"languages" title:nil subIntents:@[@"objectivec", @"javascript", @"html", @"css"] detailView:nil description:@"I code and develop for Web and iOS, in 4 different languages"]];
    
    /* TV */
    
    [intents addObject:[self intentWithID:@"modernfamily" title:@"Watching Modern Family" subIntents:@[] detailView:nil description:@"I love MF, my favorite TV show, but hate the cheesy endings"]];
    [intents addObject:[self intentWithID:@"thebigbangtheory" title:@"Watching The Big Bang Theory" subIntents:@[] detailView:nil description:@"TBBT is also a good show, Sheldon is awesome"]];
    [intents addObject:[self intentWithID:@"parksandrec" title:@"Watching Parks and Rec" subIntents:@[] detailView:nil description:@"Ron Swanson for president"]];
    [intents addObject:[self intentWithID:@"theoffice" title:@"Watching The Office" subIntents:@[] detailView:nil description:@"Michael Scott is the best TV character of all time"]];
    [intents addObject:[self intentWithID:@"tv" title:nil subIntents:@[@"modernfamily", @"thebigbangtheory", @"parksandrec", @"theoffice"] detailView:nil description:@"I'm a TV junkie, it's how I procrastinate all my development projects, I watch four TV shows"]];
    
    /* Hobbies */
    
    [intents addObject:[self intentWithID:@"hobbies" title:@"My Hobbies" subIntents:@[@"languages", @"music", @"tv"] detailView:nil description:@"I have three simple hobbies: developing, playing music and watching TV"]];
    
    /* Internship */
    
    [intents addObject:[self intentWithID:@"internship" title:@"Upcoming SingPost Internship" subIntents:@[] detailView:[self constructInfoViewWithContent:@{kContentIcon: @"internship.jpg", kContentTitle: @"SingPost Internship", kContentBody: @"I'll be working at SingPost this summer, I'm thrilled, it'll be my first internship ever. I'm going to be revamping one of their neat mobile apps, and doing R&D on how Google Glass (with my unit) can aid the day-to-day lives of postmen. This internship will help me in my development skills, look great on a resume, and will be overall a rewarding, informative, fun experience. I can't wait. FYI some WWDC design sessions could really aid me in this!"}] description:@"I'll be interning at SingPost this summer"]];
    
    /* Life */
    
    [intents addObject:[self intentWithID:@"life" title:@"Life is Good" subIntents:@[] detailView:nil description:@"Life is good, would be even better if I got to attend WWDC 2014!"]];
    
    /* Movie */
    
    [intents addObject:[self intentWithID:@"movie" title:@"Favorite Movie" subIntents:@[] detailView:nil description:@"Regardless of what my friend Siri says, Inception is the best movie ever"]];
    
    /* Projects */

    [intents addObject:[self intentWithID:@"projects" title:nil subIntents:@[@"internship", @"hacks", @"apps"] detailView:nil description:@"Made a few hacks, done a few apps, and have an upcoming internship this summer"]];

    /* School */
    
    [intents addObject:[self intentWithID:@"school" title:@"Educational Background" subIntents:@[] detailView:[self constructDetailViewFromWebsiteTemplate:@{kContentIcon: @"school.jpg", kContentTitle: @"UWCSEA - My School", kContentBody: @"I attend UWCSEA, which stands for United World College of South East Asia. I go to the Dover campus in Singapore, there are over 13 UWC schools worldwide. Our school focuses on service, helping others in the community, locally, and worldwide. Our honorary president was Nelson Mandela, and the the president is Her Majesty Queen Noor of Jordan, with Prince Charles being very closely affiliated. I take Higher C.I.M Math, Coordinated Science, English, Chinese, Music, ICT and Economics. Not to boast or anything, but my grades are really good! Swipe to view my school's website >", kContentURL: kSchoolURL}] description:@"I attend UWCSEA, my favorite subject is Economics!"]];
    
    /* Secret */
    
    [intents addObject:[self intentWithID:@"secret" title:@"My Biggest Secret" subIntents:@[] detailView:nil description:@"I stay up coding every school night till 5am, #Hardcore"]];
    
    /* Video */
    
    [intents addObject:[self intentWithID:@"video" title:@"A Special Video" subIntents:@[] detailView:[self constructWebViewWithContent:@{kContentURL: kVideoURL} withFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height)] description:@"A special video directed from my heart"]];
    
    /* Why */
    
    [intents addObject:[self intentWithID:@"why" title:@"Why I Develop" subIntents:@[] detailView:[self constructInfoViewWithContent:@{kContentIcon: @"why.jpg", kContentTitle: @"Why I Develop", kContentBody: @"Programming is my life. I come back from school everyday, sit down, code a bit, and eventually release apps to the App Store, or sell my code for a bit of $$$. But why? Sure, writing code is fun, and developing apps looks good on my resume - but there's more to that.\r\rIt's about making stuff that can solve real world problems, technology. Take Travelog, it's about making the lives of travellers easier - quickly access useful data rather than scouring the web and social networks. Take the parking and taxi app, both are helping people access things conveniently and quickly via technology. I'm working for SingPost this summer on how we can implement Google Glass into the daily lives of postmen, for efficiency, conveniency, speed and ease. We design technology to solve problems, and that's what I love doing."}] description:@"I develop software to solve real world problems"]];
    
    /* WWDC */
    
    [intents addObject:[self intentWithID:@"wwdc" title:@"Why WWDC?" subIntents:@[] detailView:[self constructInfoViewWithContent:@{kContentIcon: @"wwdc.jpg", kContentTitle: @"Why WWDC?", kContentBody: @"In 2012, I applied for a scholarship to attend WWDC. I was rejected. But that's okay, I took the next year to grow as a developer, make my portfolio more convincing and try to win. So in 2013, I was flabbergasted when I got the congratulatory winning email. It made me feel sick with happiness, which however could also be attributed to the lack of sleep the night before. May this be a reminder to release the results a bit earlier this year :p I wanted it so bad, I love Apple, and I love development, WWDC is my haven. After attending last year, the highlights of the event were: a) the keynote b) great, informative sessions c) hanging out with friends d) awesome sauce San Francisco. And for all these reasons, I want to attend again. Hell, I need to attend again! WWDC is what I look forward to at the start of every year. I've put a lot of effort and heart into this app, it reflects on how much I care about this conference. Thanks for opening this scholarship to us students."}] description:@"Learn, enhance apps, experience, fun, network, party, San Francisco, friends, the list goes on"]];
    
    [[RKDataStore sharedIntentStore] writeIntents:intents];
}

+ (RKIntent *)intentWithID:(NSString *)ID title:(NSString *)title subIntents:(NSArray *)subIntents detailView:(UIView *)detailView description:(NSString *)description {
    
    return [[RKIntent alloc] initWithID:ID title:title intentType:kIntentTypeWit subIntents:subIntents detailView:detailView logoPath:[ID stringByAppendingString:@".jpg"] description:description];
}

#pragma mark - View Construction

+ (UIView *)constructDetailViewFromWebsiteTemplate:(NSDictionary *)content {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollsToTop:NO];
    [scrollView setBounces:NO];
    [scrollView setCanCancelContentTouches:NO];
    [scrollView setContentSize:CGSizeMake(640, view.frame.size.height)];
    [view addSubview:scrollView];
    
    [scrollView addSubview:[self constructInfoViewWithContent:content]];
    [scrollView addSubview:[self constructWebViewWithContent:content withFrame:CGRectMake(320, 0, 320, [[UIScreen mainScreen] bounds].size.height)]];

    return view;
}

+ (UIView *)constructDetailViewFromAppTemplate:(NSDictionary *)content {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollsToTop:NO];
    [scrollView setBounces:NO];
    [scrollView setCanCancelContentTouches:NO];
    [scrollView setContentSize:CGSizeMake(view.frame.size.width * (((NSArray *)content[kContentScreenshots]).count + 1), view.frame.size.height)];
    [view addSubview:scrollView];

    [scrollView addSubview:[self constructInfoViewWithContent:content]];
    
    for (NSInteger i = 0; i <= ((NSArray *)content[kContentScreenshots]).count - 1; i++) {
        
        UIImageView *screenshot = [[UIImageView alloc] initWithFrame:CGRectMake(320 * (i + 1), 0, view.frame.size.width, view.frame.size.height)];
        [screenshot setImage:[UIImage imageNamed:content[kContentScreenshots][i]]];
        [scrollView addSubview:screenshot];
    }
    
    return view;
}

+ (UIWebView *)constructWebViewWithContent:(NSDictionary *)content withFrame:(CGRect)frame {
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:content[kContentURL]]]];
    
    return webView;
}

+ (UIView *)constructInfoViewWithContent:(NSDictionary *)content {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width / 2) - 50, 50, 100, 100)];
    [imageView.layer setCornerRadius:50.0f];
    [imageView.layer setMasksToBounds:YES];
    [imageView setImage:[UIImage imageNamed:content[kContentIcon]]];
    
    [view addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 50)];
    [titleLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:25.0f]];
    [titleLabel setTextColor:[UIColor darkGrayColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:content[kContentTitle]];
    
    [view addSubview:titleLabel];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake((view.frame.size.width / 2) - 140, 200, 280, view.frame.size.height - 220)];
    [textView setEditable:NO];
    [textView setScrollEnabled:YES];
    [textView setDataDetectorTypes:UIDataDetectorTypeAll];
    [textView setFont:[UIFont fontWithName:@"Avenir-Book" size:15.0f]];
    [textView setTextColor:[UIColor lightGrayColor]];
    [textView setText:content[kContentBody]];
    
    [view addSubview:textView];
    
    return view;
}

@end