//
//  UserDirectory.h
//  videochat
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDirectory : NSObject

@property (nonatomic, copy) NSString *name;

-(id)initWithName:(NSString *)name;

@end
