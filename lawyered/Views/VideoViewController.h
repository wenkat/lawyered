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

@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeConnectionsLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *actionToolBar;

- (void)doConnect;
- (void)doPublish;
- (UILabel *)GetStopWatchLabel;

@end
