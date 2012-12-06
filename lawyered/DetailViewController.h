//
//  DetailViewController.h
//  lawyered
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserDirectory;

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) UserDirectory *partner;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

-(void) setUserId:(NSString *)user_id;
@end
