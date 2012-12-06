//
//  VideoViewController.m
//  lawyered
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "VideoViewController.h"
#import "VideoSession.h"
#import "IOSUtils.h"

@interface VideoViewController ()
{
    bool masterIsVisible;
}

@end

@implementation VideoViewController {
    OTSession* _session;
    OTPublisher* _publisher;
    OTSubscriber* _subscriber;
    VideoSession* _vSession;
}

static NSString* const kApiKey = @"20750151";
static bool subscribeToSelf = YES; // Change to NO if you want to subscribe to

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showMasterView];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)willRotateToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        [self hideMasterView];
    } else {
        [self showMasterView];
    }
}

/* TokBox Functions */


- (void)updateSubscriber {
    for (NSString* streamId in _session.streams) {
        OTStream* stream = [_session.streams valueForKey:streamId];
        if (![stream.connection.connectionId isEqualToString: _session.connection.connectionId]) {
            _subscriber = [[OTSubscriber alloc] initWithStream:stream delegate:self];
            break;
        }
    }
}

- (void)doConnect
{
    [_session addObserver:self
               forKeyPath:@"connectionCount"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    [_session connectWithApiKey:kApiKey token: [_vSession getSessionToken]];
    
}

- (void)doPublish
{
    int toolbarHelight = self.actionToolBar.layer.frame.size.height;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height - toolbarHelight;
    double widgetHeight = screenHeight/4;
    double widgetWidth = screenWidth/4;
    
    _publisher = [[OTPublisher alloc] initWithDelegate:self];
    [_publisher setName:[[UIDevice currentDevice] name]];
    _publisher.publishAudio = YES;
    _publisher.publishVideo = YES;
    [_session publish:_publisher];
    [self.view addSubview:_publisher.view];
    [_publisher.view setFrame:CGRectMake(screenWidth - widgetWidth, screenHeight - widgetHeight - (toolbarHelight / 2), widgetWidth, widgetHeight)];
    
    _publisher.view.layer.masksToBounds = NO;
    _publisher.view.layer.cornerRadius = 10; // if you like rounded corners
    _publisher.view.layer.shadowOffset = CGSizeMake(-15, 20);
    _publisher.view.layer.shadowRadius = 10;
    _publisher.view.layer.shadowOpacity = 0.8;
    _publisher.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:_publisher.view.bounds].CGPath;
}

- (void)sessionDidConnect:(OTSession*)session
{
    NSLog(@"sessionDidConnect (%@)", session.sessionId);
    [self doPublish];
}

- (void)sessionDidDisconnect:(OTSession*)session
{
    NSString* alertMessage = [NSString stringWithFormat:@"Session disconnected: (%@)", session.sessionId];
    NSLog(@"sessionDidDisconnect (%@)", alertMessage);
    [IOSUtils showAlert:alertMessage];
}


- (void)session:(OTSession*)mySession didReceiveStream:(OTStream*)stream
{
    NSLog(@"session didReceiveStream (%@)", stream.streamId);
    
    // See the declaration of subscribeToSelf above.
    if ( (subscribeToSelf && [stream.connection.connectionId isEqualToString: _session.connection.connectionId])
        ||
        (!subscribeToSelf && ![stream.connection.connectionId isEqualToString: _session.connection.connectionId])
        ) {
        if (!_subscriber) {
            _subscriber = [[OTSubscriber alloc] initWithStream:stream delegate:self];
            [_vSession StartTimerTick];
        }
    }
    [_vSession StartTimerTick];
}

- (void)subscriberDidConnectToStream:(OTSubscriber*)subscriber
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    NSLog(@"subscriberDidConnectToStream (%@)", subscriber.stream.connection.connectionId);
    [subscriber.view setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view insertSubview:subscriber.view atIndex:0];
}

- (void)session:(OTSession*)session didDropStream:(OTStream*)stream{
    NSLog(@"session didDropStream (%@)", stream.streamId);
    NSLog(@"_subscriber.stream.streamId (%@)", _subscriber.stream.streamId);
    if (!subscribeToSelf
        && _subscriber
        && [_subscriber.stream.streamId isEqualToString: stream.streamId])
    {
        _subscriber = nil;
        [self updateSubscriber];
    }
}


/*
 Observers
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"connectionCount"]) {
        self.activeConnectionsLabel.text = [NSString stringWithFormat:@"Connections: %d Streams: %d", ((OTSession*)object).connectionCount, _session.streams.count];
    }
}


/*
 Error Handling
 */

- (void)publisher:(OTPublisher*)publisher didFailWithError:(OTError*) error {
    NSLog(@"publisher didFailWithError %@", error);
    [IOSUtils showAlert:[NSString stringWithFormat:@"There was an error publishing."]];
}

- (void)subscriber:(OTSubscriber*)subscriber didFailWithError:(OTError*)error
{
    NSLog(@"subscriber %@ didFailWithError %@", subscriber.stream.streamId, error);
    [IOSUtils showAlert:[NSString stringWithFormat:@"There was an error subscribing to stream %@", subscriber.stream.streamId]];
}

- (void)session:(OTSession*)session didFailWithError:(OTError*)error {
    NSLog(@"sessionDidFail");
    [IOSUtils showAlert:[NSString stringWithFormat:@"There was an error connecting to session %@", session.sessionId]];
}



/* iPad Split View Related Functions */

-(void) addBorderForMasterView
{
    UIView *rootView = [[self.splitViewController.viewControllers
                         objectAtIndex:0] view];
    rootView.layer.borderWidth = 1.0f;
    rootView.layer.cornerRadius =10.0f;
    rootView.layer.shadowOpacity = 0.8f;
    rootView.layer.shadowOffset = CGSizeMake(-5, 0);
    
    rootView.layer.masksToBounds = NO;
    rootView.layer.shadowRadius = 20;
    rootView.layer.shadowPath = [UIBezierPath bezierPathWithRect:rootView.bounds].CGPath;
}

- (void)showMasterView
{
    if (!masterIsVisible)
    {
        masterIsVisible = YES;
        NSArray *controllers = self.splitViewController.viewControllers;
        UIViewController *rootViewController = [controllers objectAtIndex:0];
        
        UIView *rootView = rootViewController.view;
        CGRect rootFrame = rootView.frame;
        rootFrame.origin.x += rootFrame.size.width;
        
        [UIView beginAnimations:@"showMasterView" context:NULL];
        rootView.frame = rootFrame;
        [UIView commitAnimations];
        [self addBorderForMasterView];
    }
}

- (void)hideMasterView
{
    if (masterIsVisible)
    {
        masterIsVisible = NO;
        NSArray *controllers = self.splitViewController.viewControllers;
        UIViewController *rootViewController = [controllers objectAtIndex:0];
        
        UIView *rootView = rootViewController.view;
        CGRect rootFrame = rootView.frame;
        rootFrame.origin.x -= rootFrame.size.width;
        
        [UIView beginAnimations:@"showView" context:NULL];
        rootView.frame = rootFrame;
        [UIView commitAnimations];

    }
}

/* Other Interface functions to Utils */

- (UILabel *)GetStopWatchLabel
{
    return [self stopWatchLabel];
}

-(void) startVideoSession
{
    _vSession = [VideoSession alloc];
    [_vSession initialize:self user_id:_user_id partner_id:_partner_id];
    _session = [[OTSession alloc] initWithSessionId: [_vSession getSessionId]
                                           delegate:self];
    [self doConnect];
}

- (void)setSessionBetween:(NSString *)user partner_id:(NSString *)partner
{
    self.user_id = user;
    self.partner_id = partner;
    
    [self startVideoSession];
    
}

- (void)viewDidUnload
{
    [self setStopWatchLabel:nil];
    [self setActiveConnectionsLabel:nil];
    [self setActionToolBar:nil];
    [super viewDidUnload];
}

@end
