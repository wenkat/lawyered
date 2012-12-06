//
//  VideoViewController.h
//  lawyered
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Opentok/Opentok.h>

@interface VideoViewController : UIViewController <OTSessionDelegate, OTSubscriberDelegate, OTPublisherDelegate>

@property (weak, nonatomic) NSString *user_id;
@property (weak, nonatomic) NSString *partner_id;
@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeConnectionsLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *actionToolBar;

- (void)doConnect;
- (void)doPublish;
- (UILabel *)GetStopWatchLabel;
- (void)setSessionBetween:(NSString *)user  partner:(NSString *)partner;
- (void)startVideoSession;

@end
