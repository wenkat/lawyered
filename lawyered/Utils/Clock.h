//
//  Clock.h
//  lawyered
//
//  Created by Venkateswaran Shankar on 03/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Clock : NSObject
{
IBOutlet UILabel* clockLabel;
NSTimer *myTicker;
NSDate *startDate;
NSDate *endDate;
    
}

/* New Methods */
- (void) runTimer:(UILabel *)stopWatchLabel;
- (void) updateTimer;

@end
