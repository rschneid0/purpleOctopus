//
//  AppDelegate.h
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/8/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MainViewController.h"
#import "MagicalRecord.h"
#import "NavigationViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

