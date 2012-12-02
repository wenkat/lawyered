//
//  UserDirectory.m
//  videochat
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "UserDirectory.h"

@implementation UserDirectory

-(id) initWithName:(NSString *)name
{
    {
        self = [super init];
        if (self) {
            _name = name;
            return self;
        }
        return nil;
    }
}
@end
