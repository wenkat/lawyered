//
//  MasterViewController.m
//  lawyered
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "UserDirectory.h"
#import "UserDataController.h"

/*
 
@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end
 
 */

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    self.dataController = [[UserDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"UserCell";
    
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UserDirectory *userAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
    [[cell textLabel] setText:userAtIndex.name];
    [[cell detailTextLabel] setText:@""];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowUserDetails"])
    {
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.partner = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailViewController.user_id = [self.dataController GetUserID];
    }
}

@end
