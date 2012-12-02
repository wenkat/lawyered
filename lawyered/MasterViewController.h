//
//  MasterViewController.h
//  lawyered
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserDataController;
@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) UserDataController *dataController;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
