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

@property (strong, nonatomic) UserDirectory *user;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end
