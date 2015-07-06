//
//  AppDelegate.m
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/8/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UINavigationController *nav;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    [MagicalRecord setupCoreDataStack];
    [Parse setApplicationId:@"y0jJbN50xoV82rgrnK9w9hmtUZpNsheXwYwy3Sci"
                  clientKey:@"ZqfvGt1fZsREOCpZbYkRdxzLv80VVdyAjgrQcvfg"];
    
    // Override point for customization after application launch.
       nav = [[UINavigationController alloc]  init];
    nav.navigationBar.hidden=YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    //[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //[MagicalRecord setupCoreDataStackWithStoreNamed:@"OrangeEel"];
    
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        UILabel* PurpleOcto = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, 100)];
        [PurpleOcto setText:@"PurpleOctopus"];
        [PurpleOcto setFont:[UIFont fontWithName:@"Helvetica" size:22]];
        logInViewController.logInView.logo=PurpleOcto;
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        signUpViewController.title=@"YOLO";
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [nav presentViewController:logInViewController animated:YES completion:NULL];
    }
    else{
        MainViewController *mvc = [[MainViewController alloc] initWithNibName:nil bundle:nil];
        NavigationViewController *lvc = [[NavigationViewController alloc] init];
        
        MMDrawerController * drawerController = [[MMDrawerController alloc]
                                                 initWithCenterViewController:mvc
                                                 leftDrawerViewController:lvc
                                                 rightDrawerViewController:nil];
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [drawerController setMaximumLeftDrawerWidth:150.0];
        [drawerController setMaximumRightDrawerWidth:0.001];
        mvc.container=drawerController;
        lvc.container=drawerController;
        //lvc.view.backgroundColor=[UIColor redColor];
        mvc.view.backgroundColor=[UIColor orangeColor];
        [nav presentViewController:drawerController animated:NO completion:nil];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"YEAH BUDDy");
  [nav dismissViewControllerAnimated:YES completion:NULL];
    MainViewController *mvc = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    NavigationViewController *lvc = [[NavigationViewController alloc] init];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:mvc
                                             leftDrawerViewController:lvc
                                             rightDrawerViewController:nil];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setMaximumLeftDrawerWidth:150.0];
    [drawerController setMaximumRightDrawerWidth:0.001];
    mvc.container=drawerController;
    lvc.container=drawerController;
    //lvc.view.backgroundColor=[UIColor redColor];
    mvc.view.backgroundColor=[UIColor orangeColor];
    [nav presentViewController:drawerController animated:NO completion:nil];

}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [nav popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [nav dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

@end
