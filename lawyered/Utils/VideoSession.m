//
//  vSession.m
//  videochat
//
//  Created by Venkateswaran Shankar on 07/07/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoViewController.h"
#import "VideoSession.h"
#import "Clock.h"
#import "IOSUtils.h"
#import "UserInterface.h"

@implementation VideoSession 

-(void) initialize:(VideoViewController *) frame
{
    videoViewController = frame;
    me = [UserInterface alloc];
    if (![me login]) {
        [IOSUtils showAlert:@"Login Unsuccessfull" ];
    }
    user_id = [me getUserID];
    partner_id = [me getPartnerID];
    
    NSLog(@"User_Id: %@, PartnerId: %@", user_id, partner_id);
    
    NSString* url = [NSString stringWithFormat:vGetSessionUrl, user_id, partner_id];
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
    vSessionId = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"vSessionId %@", vSessionId);

    url = [NSString stringWithFormat:vGetTokenUrl, user_id, partner_id];
    data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
    vToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"vToken %@", vToken);
    
}

-(void) StartTimerTick
{
    Clock* clock = [Clock alloc];
    [clock runTimer: [videoViewController GetStopWatchLabel]];
}

-(NSString *) getSessionId
{
    return vSessionId;
}

-(NSString *) getSessionToken
{
    return vToken;
}

-(void) deinitialize
{
    [me logout];
}
@end
