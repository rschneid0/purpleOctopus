//
//  NavigationViewController.h
//  purpleOctopus
//
//  Created by Rolando Schneiderman on 6/3/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//
#import "MMDrawerController.h"

#import <UIKit/UIKit.h>

@protocol navDelegate <NSObject>

@optional
-(void)showCalendarView;
-(void)showStudentView;
-(void)showAssignmentView;
-(void)showPaymentView;
-(void)showSettingsView;

@end

@interface NavigationViewController : UIViewController


@property UIButton* calendarButton;
@property UIButton* assignments;
@property UIButton* students;
@property UIButton* payment;
@property UIButton* settings;
@property id<navDelegate> navDelegate;
@property MMDrawerController* container;

@end
