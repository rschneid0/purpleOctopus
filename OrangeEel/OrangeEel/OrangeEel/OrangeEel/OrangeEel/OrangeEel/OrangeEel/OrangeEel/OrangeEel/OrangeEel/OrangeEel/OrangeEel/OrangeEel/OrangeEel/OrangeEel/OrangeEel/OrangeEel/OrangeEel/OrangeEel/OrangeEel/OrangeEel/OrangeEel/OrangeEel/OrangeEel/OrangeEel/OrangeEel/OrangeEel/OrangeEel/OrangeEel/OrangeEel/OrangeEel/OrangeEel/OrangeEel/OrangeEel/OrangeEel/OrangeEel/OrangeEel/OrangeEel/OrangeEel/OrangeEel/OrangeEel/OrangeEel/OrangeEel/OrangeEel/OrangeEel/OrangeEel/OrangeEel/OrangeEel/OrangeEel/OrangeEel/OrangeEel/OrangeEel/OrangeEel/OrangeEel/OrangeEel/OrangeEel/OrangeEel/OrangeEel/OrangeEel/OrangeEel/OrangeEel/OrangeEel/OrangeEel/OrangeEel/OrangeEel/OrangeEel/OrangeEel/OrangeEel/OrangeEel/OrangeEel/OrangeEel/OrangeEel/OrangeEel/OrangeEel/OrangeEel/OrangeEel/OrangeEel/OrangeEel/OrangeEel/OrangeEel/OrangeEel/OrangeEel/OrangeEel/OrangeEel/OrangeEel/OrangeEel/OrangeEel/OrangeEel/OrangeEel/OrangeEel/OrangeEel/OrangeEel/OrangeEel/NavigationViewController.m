//
//  NavigationViewController.m
//  purpleOctopus
//
//  Created by Rolando Schneiderman on 6/3/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController
@synthesize calendarButton, assignments, students, payment, settings;

-(id)init{
    self= [super init];
    
    if(self){
        [self.view setBackgroundColor:[UIColor grayColor]];
        
        UIImageView* profileView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 25, 100, 100)];
        [profileView setImage:[UIImage imageNamed:@"unknown_user.png"]];
        [profileView setContentMode:UIViewContentModeScaleAspectFit];
        [profileView setBackgroundColor:[UIColor whiteColor]];
        profileView.clipsToBounds=YES;
        [[profileView layer] setCornerRadius:50];
        
        [self.view addSubview:profileView];
        
        
        calendarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [calendarButton setFrame:CGRectMake(5, 150, 145, 50)];
        [calendarButton setTitle:@"Calendar" forState:UIControlStateNormal];
        [calendarButton addTarget:self action:@selector(calendarButtonPressed) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:calendarButton];
        
        students = [UIButton buttonWithType:UIButtonTypeCustom];
        [students setFrame:CGRectMake(5, 200, 145, 50)];
        [students setTitle:@"Students" forState:UIControlStateNormal];
        [students addTarget:self action:@selector(studentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:students];

        assignments = [UIButton buttonWithType:UIButtonTypeCustom];
        [assignments setFrame:CGRectMake(5, 250, 145, 50)];
        [assignments setTitle:@"Assignments" forState:UIControlStateNormal];
        [assignments addTarget:self action:@selector(assignmentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:assignments];

        payment = [UIButton buttonWithType:UIButtonTypeCustom];
        [payment setFrame:CGRectMake(5, 300, 145, 50)];
        [payment setTitle:@"Payment" forState:UIControlStateNormal];
        [payment addTarget:self action:@selector(paymentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:payment];

        settings = [UIButton buttonWithType:UIButtonTypeCustom];
        [settings setFrame:CGRectMake(5, 350, 145, 50)];
        [settings setTitle:@"Settings" forState:UIControlStateNormal];
        [settings addTarget:self action:@selector(settingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:settings];
        
    }
    return self;
}

-(void)calendarButtonPressed{
    [self.navDelegate showCalendarView];
}
-(void)studentButtonPressed{
    [self.navDelegate showStudentView];
}
-(void)assignmentButtonPressed{
    [self.navDelegate showAssignmentView];
}
-(void)paymentButtonPressed{
    [self.navDelegate showPaymentView];
}
-(void)settingButtonPressed{
    [self.navDelegate showSettingsView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
