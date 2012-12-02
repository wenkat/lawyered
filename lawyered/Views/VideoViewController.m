//
//  VideoViewController.m
//  lawyered
//
//  Created by Venkateswaran Shankar on 02/12/12.
//  Copyright (c) 2012 Venkateswaran Shankar. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "VideoViewController.h"

@interface VideoViewController ()
{
    bool masterIsVisible;
}

@end
@implementation VideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        [self showMasterView];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)willRotateToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        [self hideMasterView];
    } else {
        [self showMasterView];
    }
}

-(void) addBorderForMasterView
{
    UIView *rootView = [[self.splitViewController.viewControllers
                         objectAtIndex:0] view];
    rootView.layer.borderWidth = 1.0f;
    rootView.layer.cornerRadius =10.0f;
    rootView.layer.shadowOpacity = 0.8f;
    rootView.layer.shadowOffset = CGSizeMake(-5, 0);
    
    rootView.layer.masksToBounds = NO;
    rootView.layer.shadowRadius = 20;
    rootView.layer.shadowPath = [UIBezierPath bezierPathWithRect:rootView.bounds].CGPath;
}

- (void)showMasterView
{
    if (!masterIsVisible)
    {
        masterIsVisible = YES;
        NSArray *controllers = self.splitViewController.viewControllers;
        UIViewController *rootViewController = [controllers objectAtIndex:0];
        
        UIView *rootView = rootViewController.view;
        CGRect rootFrame = rootView.frame;
        rootFrame.origin.x += rootFrame.size.width;
        
        [UIView beginAnimations:@"showMasterView" context:NULL];
        rootView.frame = rootFrame;
        [UIView commitAnimations];
        [self addBorderForMasterView];
    }
}

- (void)hideMasterView
{
    if (masterIsVisible)
    {
        masterIsVisible = NO;
        NSArray *controllers = self.splitViewController.viewControllers;
        UIViewController *rootViewController = [controllers objectAtIndex:0];
        
        UIView *rootView = rootViewController.view;
        CGRect rootFrame = rootView.frame;
        rootFrame.origin.x -= rootFrame.size.width;
        
        [UIView beginAnimations:@"showView" context:NULL];
        rootView.frame = rootFrame;
        [UIView commitAnimations];

    }
}

- (void)viewDidUnload
{
    
    [self setNavigation:nil];
    [super viewDidUnload];
}

@end
