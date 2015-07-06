//
//  ViewController.m
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/8/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end
@implementation MainViewController
@synthesize tld, eventsByDate;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    tld= [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65)];
    tld.delegate=self;
    tld.dataSource=self;

    assignmentView = [[UIView alloc] initWithFrame:self.view.frame];
    
    UIButton* hamburgerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hamburgerButton setFrame:CGRectMake(0, 10, 65, 55)];
    [hamburgerButton setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
    [hamburgerButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [hamburgerButton addTarget:self action:@selector(openDrawer) forControlEvents:UIControlEventTouchUpInside];

    [assignmentView addSubview:hamburgerButton];
    
    UIImageView* octoImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"octo.png"]];
    [octoImageView1 setFrame:CGRectMake(self.view.frame.size.width/2-50, 20, 100, 35)];
    [octoImageView1 setContentMode:UIViewContentModeScaleAspectFit];
    [assignmentView addSubview:octoImageView1];
    
    [assignmentView addSubview:tld];

    self.currentDirectory=nil;
    UIButton* newDir = [UIButton buttonWithType:UIButtonTypeCustom];
    [newDir setFrame:CGRectMake(5, self.view.frame.size.height-65, 50, 50)];
    [newDir setTitle:@"F+" forState:UIControlStateNormal];
    [newDir setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    [newDir setBackgroundColor:[UIColor whiteColor]];
    [newDir addTarget:self action:@selector(newDirectory) forControlEvents:UIControlEventTouchUpInside];
    [assignmentView addSubview:newDir];
    
    Save= [UIButton buttonWithType:UIButtonTypeCustom];
    [Save setFrame:CGRectMake(60, self.view.frame.size.height-65, 50, 50)];
    [Save setBackgroundColor:[UIColor whiteColor]];
    [Save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    [Save setTitle:@"A+" forState:UIControlStateNormal];
    [Save addTarget:self action:@selector(newAssignment) forControlEvents:UIControlEventTouchUpInside];
    [assignmentView addSubview:Save];
    Save.hidden=YES;
    
    UIButton* burrow = [UIButton buttonWithType:UIButtonTypeCustom];
    [burrow setFrame:CGRectMake(115, self.view.frame.size.height-65, 50, 50)];
    [burrow setBackgroundColor:[UIColor whiteColor]];
    [burrow setTitle:@"Up" forState:UIControlStateNormal];
    [burrow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;

    [burrow addTarget:self action:@selector(unburrow) forControlEvents:UIControlEventTouchUpInside];
    [assignmentView addSubview:burrow];
    [self.view addSubview:assignmentView];
    
    //calendar subview
    calendarView = [[UIView alloc] initWithFrame:self.view.frame];
    UIView* tcv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    [tcv setBackgroundColor:[UIColor colorWithRed:185.0/255.0 green:184.0/255.0 blue:249.0/255.0 alpha:1]];
    [calendarView addSubview:tcv];
    UIButton* hamburgerButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [hamburgerButton2 setFrame:CGRectMake(0, 10, 65, 55)];
    [hamburgerButton2 setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
    [hamburgerButton2.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [hamburgerButton2 addTarget:self action:@selector(openDrawer) forControlEvents:UIControlEventTouchUpInside];
    [calendarView addSubview:hamburgerButton2];

    
    
    self.calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.width)];
    [calendarView addSubview:self.calendarContentView];
    [calendarView bringSubviewToFront:self.calendarContentView];

    self.calendarMenuView=[[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 55)];
    [calendarView addSubview:self.calendarMenuView];
    
    
    //sample dates
    eventsByDate = [NSMutableDictionary new];
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
        [eventsByDate[key] addObject:@"Hey this is a random event!"];
    }
    
    //endsample date

    
    self.calendar = [JTCalendar new];
    
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Monday
    self.calendar.calendarAppearance.ratioContentMenu = 1.;
    self.calendar.calendarAppearance.menuMonthTextColor = [UIColor whiteColor];
    self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor blueColor];
    self.calendar.calendarAppearance.dayTextColorSelected = [UIColor whiteColor];
    //self.calendar.calendarAppearance.dayTextColor = [UIColor orangeColor];
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    [calendarView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:calendarView];
    calendarView.hidden=YES;
    [calendarView bringSubviewToFront:hamburgerButton2];
    
    eventCounterLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 50)];
    [calendarView addSubview:eventCounterLabel];
    
    UIButton* eventAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [eventAddButton setFrame:CGRectMake(self.view.frame.size.width-50, 15, 50, 50)];
    [eventAddButton setBackgroundColor:[UIColor clearColor]];
    [eventAddButton setTitle:@"+" forState:UIControlStateNormal];
    [eventAddButton addTarget:self action:@selector(showNewEventView) forControlEvents:UIControlEventTouchUpInside];

    [calendarView addSubview:eventAddButton];
    
    [self fetchData]; //get assignments tld
    
    studentView = [[StudentView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:studentView];
    studentView.hidden=YES;
    studentView.svd=self;
    paymentView= [[UIView alloc] initWithFrame:self.view.frame];
    [paymentView setBackgroundColor:[UIColor whiteColor]];
    paymentView.hidden=YES;
    UILabel* paymentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [paymentLabel setText:@"Payment page coming soon"];
    [paymentView addSubview:paymentLabel];
    [self.view addSubview:paymentView];
    
    settingsView = [[UIView alloc] initWithFrame:self.view.frame];
    [settingsView setBackgroundColor:[UIColor whiteColor]];
    UILabel* settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [settingsLabel setText:@"Settings page coming soon"];
    [settingsView addSubview:settingsLabel];
    settingsView.hidden=YES;
    
    UIButton* logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton setFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 50)];
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutAndExit) forControlEvents:UIControlEventTouchUpInside];

    [logoutButton setBackgroundColor:[UIColor colorWithRed:185.0/255.0 green:184.0/255.0 blue:249.0/255.0 alpha:1]];
    [settingsView addSubview:logoutButton];
    
    [self.view addSubview:settingsView];
    
    //NSLog(@"CUrrent User: %@", [PFUser currentUser]);
    //PFUser *user = [PFUser currentUser];
    
    [self.calendar reloadAppearance];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)showNewEventView{
    NewEventView* nev = [[NewEventView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:nev];
    return;
}
-(void)logoutAndExit{
    [PFUser logOut];
    exit(0);
}
-(void)openDrawer{
    [self.container openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)hamburgerButton{
    [self openDrawer];
}

-(void)burrow{
    Directory* d = self.tableArray[0];
    
    NSPredicate *peopleFilter = [NSPredicate predicateWithFormat:@"container.name like %@",@"Did"];
    NSPredicate *directoryFilter = [NSPredicate predicateWithFormat:@"container.name like %@",@"Did"];
    //NSArray *people = [Assignment MR_findAllWithPredicate:peopleFilter];
    
    
    
    self.tableArray = [[Assignment MR_findAllWithPredicate:peopleFilter] mutableCopy];
    //[self.tableArray addObjectsFromArray:[Directory MR_findAllWithPredicate:peopleFilter]];
    [self.tld reloadData];
    NSLog(@"TA Burrow SIZE: %ld", [self.tableArray count]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchData{
    self.tableArray = [[Directory MR_findByAttribute:@"container" withValue:[NSNull null]] mutableCopy];
    [self.tld reloadData];
    NSLog(@"TA SIZE: %ld", [self.tableArray count]);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag==1234) {
    Directory* d = [Directory MR_createEntity];
    d.name=textField.text;
    d.container=self.currentDirectory;
    
    //Assignment* a = [Assignment MR_createEntity];
    //a.notes=@"Silly Assignment";
    //a.container=d;
    //[d addContentsAObject:a];
    
    [self saveContext];
        if (self.currentDirectory==nil) {
            [self fetchData];
        }
        else
        {
            NSPredicate *peopleFilter = [NSPredicate predicateWithFormat:@"container.name like %@", self.currentDirectory.name ];
            self.tableArray = [[Assignment MR_findAllWithPredicate:peopleFilter] mutableCopy];
            [self.tableArray addObjectsFromArray:[[Directory MR_findAllWithPredicate:peopleFilter] mutableCopy]];
        }
        [grayView removeFromSuperview];
    }
    [tld reloadData];
    [textField resignFirstResponder];
    [textField removeFromSuperview];
    return YES;
}

-(void)saveAssignment:(Assignment*)a{
    a.container=self.currentDirectory;
    [self.currentDirectory addContentsAObject:a];
    NSLog(@"A NOTEA: %@", a.notes);
    [self saveContext];
}

-(void)cancelEverything{
    [sneakyButton removeFromSuperview];
    [grayView removeFromSuperview];
    [tf resignFirstResponder];
    [tf removeFromSuperview];
    [self.container setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.currentDirectory==nil) {
        return @"/";
    }
    NSString* title = [NSString stringWithFormat:@"%@", self.currentDirectory.name];
    
    
    Directory* ptr = self.currentDirectory;
    //NSLog(@"Current Directory name: %@", self.currentDirectory.name);
    
    while (ptr.container!=NULL) {
       title =[NSString stringWithFormat:@"%@/%@", ptr.container.name ,title];
        //NSLog(@"ptr.container: %@", ptr.container.name);
        ptr=ptr.container;
    }
    if (ptr.container==NULL) {
        title =[NSString stringWithFormat:@"/%@",title];
    }
    return  title;
    //return self.currentDirectory.name;
}

-(void)newDirectory{
    [self.container setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    grayView = [[UIView alloc] initWithFrame:self.view.frame];
    [grayView setBackgroundColor:[UIColor blackColor]];
    grayView.alpha=.5;
    [self.view addSubview:grayView];
    sneakyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sneakyButton addTarget:self action:@selector(cancelEverything) forControlEvents:UIControlEventTouchUpInside];
    [sneakyButton setFrame:self.view.frame];
    [self.view addSubview:sneakyButton];
    tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 115, self.view.frame.size.width, 20)];
    [tf becomeFirstResponder];
    [tf setTextAlignment:NSTextAlignmentCenter];
    tf.delegate=self;
    tf.tag=1234;
    tf.backgroundColor=[UIColor whiteColor];
    tf.placeholder=@"New Folder title";
    [self.view addSubview:tf];
    
    
}

- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
    [self.tld reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableArray.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    if ([[self.tableArray objectAtIndex:indexPath.row] isKindOfClass:[Directory class]]) {

    Directory* d = [self.tableArray objectAtIndex:indexPath.row];
    cell.textLabel.text = d.name;
        [cell.imageView setImage:[UIImage imageNamed:@"folder.png"]];
    //self.currentDirectory=d;
    
    }
    else if ([[self.tableArray objectAtIndex:indexPath.row] isKindOfClass:[Assignment class]]){
        Assignment* d = [self.tableArray objectAtIndex:indexPath.row];
        cell.textLabel.text=d.notes;
        [cell.imageView setImage:[UIImage imageNamed:@"assignment.png"]];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[self.tableArray objectAtIndex:indexPath.row] isKindOfClass:[Directory class]]) {
        Directory* d = [self.tableArray objectAtIndex:indexPath.row];
        self.currentDirectory=d;
        NSPredicate *peopleFilter = [NSPredicate predicateWithFormat:@"container.name like %@", d.name ];
        self.tableArray = [[Assignment MR_findAllWithPredicate:peopleFilter] mutableCopy];
        [self.tableArray addObjectsFromArray:[[Directory MR_findAllWithPredicate:peopleFilter] mutableCopy]];
        [self.tld reloadData];
        Save.hidden=NO;
        return;
    }
    if ([[self.tableArray objectAtIndex:indexPath.row] isKindOfClass:[Assignment class]]) {
        Assignment* a = [self.tableArray objectAtIndex:indexPath.row];
        NSLog(@"Assignment Selected! Render View");
    }

}

-(void)unburrow{
    if (self.currentDirectory.container==nil) {
        self.currentDirectory=nil;
        [self fetchData];
        [tld reloadData];
        Save.hidden=YES;
        return;
    }
    
    self.currentDirectory=self.currentDirectory.container; //go up a directory, then populate with
    NSPredicate *peopleFilter = [NSPredicate predicateWithFormat:@"container.name like %@", self.currentDirectory.name ];
    self.tableArray = [[Assignment MR_findAllWithPredicate:peopleFilter] mutableCopy];
    [self.tableArray addObjectsFromArray:[[Directory MR_findAllWithPredicate:peopleFilter] mutableCopy]];
    [self.tld reloadData];
}

-(void)removeAVC{
    [grayView removeFromSuperview];
    [acv removeFromSuperview];
    [self reloadCurrentDirectory];
    }
-(void)reloadCurrentDirectory{
    Directory* d = self.currentDirectory;
    NSPredicate *peopleFilter = [NSPredicate predicateWithFormat:@"container.name like %@", d.name ];
    self.tableArray = [[Assignment MR_findAllWithPredicate:peopleFilter] mutableCopy];
    [self.tableArray addObjectsFromArray:[[Directory MR_findAllWithPredicate:peopleFilter] mutableCopy]];
    [self.tld reloadData];

}

-(void)newAssignment{
    
    grayView = [[UIView alloc] initWithFrame:self.view.frame];
    [grayView setBackgroundColor:[UIColor blackColor]];
    grayView.alpha=.5;
    [self.view addSubview:grayView];
    
    acv = [[AssignmentCreationView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*.05, 60+self.view.frame.size.height*.05, self.view.frame.size.width*.9, -60+self.view.frame.size.height*.9)];
    acv.backgroundColor=[UIColor whiteColor];
    acv.layer.cornerRadius = 15.0f;
    acv.clipsToBounds=YES;
    acv.delegate=self;
    [self.view addSubview:acv];
    

    
    NSLog(@"Create New Assignment");
    
    return;
}

- (void)viewDidLayoutSubviews
{
    [self.calendar repositionViews];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    
    
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    NSLog(@"Date: %@ - %ld events", date, (unsigned long)[events count]);
    
    [eventCounterLabel setText:[NSString stringWithFormat:@"%ld events on selected date", [events count]]];
    
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }

    return dateFormatter;
}

-(void)showCalendarView{
    paymentView.hidden=YES;
    settingsView.hidden=YES;
    assignmentView.hidden=YES;
    calendarView.hidden=NO;
    studentView.hidden=YES;
}

-(void)showAssignmentView{
    paymentView.hidden=YES;
    settingsView.hidden=YES;
    assignmentView.hidden=NO;
    calendarView.hidden=YES;
    studentView.hidden=YES;
}

-(void)showStudentView{
    paymentView.hidden=YES;
    settingsView.hidden=YES;
    assignmentView.hidden=YES;
    calendarView.hidden=YES;
    studentView.hidden=NO;
}
-(void)showSettingsView{
    paymentView.hidden=YES;
    settingsView.hidden=NO;
    assignmentView.hidden=YES;
    calendarView.hidden=YES;
    studentView.hidden=YES;
}
-(void)showPaymentView{
    paymentView.hidden=NO;
    settingsView.hidden=YES;
    assignmentView.hidden=YES;
    calendarView.hidden=YES;
    studentView.hidden=YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
