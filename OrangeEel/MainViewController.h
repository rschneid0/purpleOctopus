//
//  ViewController.h
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/8/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assignment.h"
#import "Directory.h"
#import "MagicalRecord.h"
#import "AssignmentCreatorDelegate.h"
#import "AssignmentCreationView.h"
#import "MMDrawerController.h"
#import "NavigationViewController.h"
#import <JTCalendar.h>
#import "JTCalendarContentView.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "StudentView.h"
#import "NewEventView.h"


@class AssignmentCreationView;


@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, AssignmentCreatorDelegate, JTCalendarDataSource,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, navDelegate, studentViewDelegate>
{
    UITextField* tf;
    UIView* grayView;
    AssignmentCreationView* acv;
    UIButton* sneakyButton;
    UIView* assignmentView;
    UIView* calendarView;
    UILabel* eventCounterLabel;
    
    
    StudentView* studentView;
    UIView* paymentView;
    UIView* settingsView;
    UIButton* Save;
}

@property UITableView* tld;
@property Directory* currentDirectory;
@property MMDrawerController* container;
@property NSMutableArray* tableArray;

@property int counter;

@property ( nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property ( nonatomic) IBOutlet JTCalendarContentView *calendarContentView;

@property (strong, nonatomic) JTCalendar *calendar;

@property NSMutableDictionary* eventsByDate;

@end

