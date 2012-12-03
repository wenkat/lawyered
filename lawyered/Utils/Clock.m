//
//  Clock.m
//  lawyered
//
//  Created by Venkateswaran Shankar on 03/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import "Clock.h"

@implementation Clock


- (void)runTimer:(UILabel *) stopWatchLabel {
    clockLabel = stopWatchLabel;
    startDate = [NSDate date];
    endDate = [NSDate dateWithTimeIntervalSinceNow: 30 * 60];
    
    myTicker = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(updateTimer)
                                              userInfo:nil
                                               repeats:YES];
    
}

- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:currentDate];
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    clockLabel.text = timeString;
}


@end
