//
//  IOSUtils.m
//  lawyered
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import "IOSUtils.h"

@implementation IOSUtils


+(NSString *) getUUID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *UUID = @"";
    
    if (![defaults valueForKey:@"UUID"])
    {
        CFUUIDRef UUIDRef = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef UUIDSRef = CFUUIDCreateString(kCFAllocatorDefault, UUIDRef);
        UUID = [NSString stringWithFormat:@"%@", UUIDSRef];
        
        [defaults setObject:UUID forKey:@"UUID"];
    }
    else {
        UUID = [defaults valueForKey:@"UUID"];
    }
    
    return UUID;
}


+ (void)showAlert:(NSString*)string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message from Lawyered"
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
