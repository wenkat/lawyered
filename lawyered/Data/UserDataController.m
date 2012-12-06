//
//  UserDataController.m
//  videochat
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "UserDataController.h"
#import "UserDirectory.h"

#import "IOSUtils.h"
#import "UserInterface.h"


static NSString* const vGetOnlineUsers = @"http://quiet-peak-9535.herokuapp.com/get_online_users?user_id=%@";

@interface UserDataController ()
{
    UserInterface *me;
    NSString *user_id;
}
- (void)initializeDefaultDataList;
- (NSString *)getOnlineUsers;
@end

@implementation UserDataController

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void)initializeDefaultDataList
{
    NSMutableArray *userList = [[NSMutableArray alloc] init];
    self.masterUsersList = userList;
    UserDirectory *userDirectory;
    
    NSString *users = [self getOnlineUsers];
    NSArray *list = [users componentsSeparatedByString:@"<br>"];
    for (int iter=0; iter < [list count] - 1; iter++)
    {
        NSString *user = [list objectAtIndex:iter];
        userDirectory = [[UserDirectory alloc] initWithName:user];
        [self addUserDirectoryWithUser:userDirectory];
    }
}

- (NSString *)getOnlineUsers
{
    me = [UserInterface alloc];
    if (![me login]) {
        [IOSUtils showAlert:@"Login Unsuccessfull" ];
    }
    user_id = [me getUserID];
    
    NSLog(@"User_Id: %@ ", user_id);
    
    NSString* url = [NSString stringWithFormat:vGetOnlineUsers, user_id];
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
    NSString *users = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return users;
    
}

-(NSString *) GetUserID
{
    return [me getUserID];
}

- (NSUInteger)countOfList {
    return [self.masterUsersList count];
}

- (UserDirectory *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterUsersList objectAtIndex:theIndex];
}

- (void)addUserDirectoryWithUser:(UserDirectory *)user {
    [self.masterUsersList addObject:(UserDirectory *)user];
}

- (void)setMasterUsersList:(NSMutableArray *)newList
{
    if (_masterUsersList != newList) {
        _masterUsersList = [newList mutableCopy];
    }
}

@end

