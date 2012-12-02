//
//  UserInterface.h
//  videochat
//
//  Created by Venkateswaran Shankar on 01/12/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInterface : NSObject
{
    NSString *user_id;
}
-(bool) login;
-(NSString *) getUserID;
-(NSString *) getPartnerID;
-(void) logout;

@end
