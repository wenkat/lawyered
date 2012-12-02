//
//  UserDataController.h
//  videochat
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserDirectory;

@interface UserDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterUsersList;

- (NSUInteger)countOfList;
- (UserDirectory *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addUserDirectoryWithUser:(UserDirectory *)user;

@end
