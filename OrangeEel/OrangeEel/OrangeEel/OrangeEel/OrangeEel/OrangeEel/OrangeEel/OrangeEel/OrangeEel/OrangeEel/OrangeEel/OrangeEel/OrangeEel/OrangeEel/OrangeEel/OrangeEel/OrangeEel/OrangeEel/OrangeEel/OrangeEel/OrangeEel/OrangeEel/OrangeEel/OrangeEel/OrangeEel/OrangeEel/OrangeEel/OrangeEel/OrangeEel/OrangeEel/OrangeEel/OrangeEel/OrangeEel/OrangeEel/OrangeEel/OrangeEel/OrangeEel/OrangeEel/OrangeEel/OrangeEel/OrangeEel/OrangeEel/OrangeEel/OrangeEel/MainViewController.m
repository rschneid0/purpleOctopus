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
    [self.view addSubview:tld];

    
    self.currentDirectory=nil;
    UIButton* newDir = [UIButton buttonWithType:UIButtonTypeCustom];
    [newDir setFrame:CGRectMake(5, self.view.frame.size.height-65, 50, 50)];
    [newDir setTitle:@"F+" forState:UIControlStateNormal];
    [newDir setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    [newDir setBackgroundColor:[UIColor whiteColor]];
    [newDir addTarget:self action:@selector(newDirectory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newDir];
    
    UIButton* Save = [UIButton buttonWithType:UIButtonTypeCustom];
    [Save setFrame:CGRectMake(60, self.view.frame.size.height-65, 50, 50)];
    [Save setBackgroundColor:[UIColor whiteColor]];
    [Save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    [Save setTitle:@"A+" forState:UIControlStateNormal];
    [Save addTarget:self action:@selector(newAssignment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Save];
    
    UIButton* burrow = [UIButton buttonWithType:UIButtonTypeCustom];
    [burrow setFrame:CGRectMake(115, self.view.frame.size.height-65, 50, 50)];
    [burrow setBackgroundColor:[UIColor whiteColor]];
    [burrow setTitle:@"Up" forState:UIControlStateNormal];
    [burrow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;

    [burrow addTarget:self action:@selector(unburrow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:burrow];
    
    
    //calendar subview
    UIView* blackOut = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:blackOut];
    [blackOut setBackgroundColor:[UIColor whiteColor]];
    
    self.calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:self.calendarContentView];
    [self.view bringSubviewToFront:self.calendarContentView];

    self.calendarMenuView=[[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [self.view addSubview:self.calendarMenuView];
    
    self.calendar = [JTCalendar new];
    
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Monday
    self.calendar.calendarAppearance.ratioContentMenu = 1.;
    self.calendar.calendarAppearance.menuMonthTextColor = [UIColor blackColor];
    self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor blueColor];
    self.calendar.calendarAppearance.dayTextColorSelected = [UIColor whiteColor];
    //self.calendar.calendarAppearance.dayTextColor = [UIColor orangeColor];
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
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

    
    [self fetchData];
    
    //NSLog(@"CUrrent User: %@", [PFUser currentUser]);
    //PFUser *user = [PFUser currentUser];
    
    UIImage *resizedImage = [UIImage imageNamed:@"folder.png"];
    
    NSData *imageData = UIImagePNGRepresentation(resizedImage);
    
    PFFile* tmpFile = [PFFile fileWithData:imageData];
    
    [tmpFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        PFUser *user = [PFUser currentUser];
        [user setObject:tmpFile forKey:@"profilePic"];
        [user saveInBackground];
        
    }];
    
    UIButton* logout = [UIButton buttonWithType:UIButtonTypeCustom];
    [logout setFrame:CGRectMake(115, self.view.frame.size.height-65, 50, 50)];
    [logout setBackgroundColor:[UIColor whiteColor]];
    [logout setTitle:@"Up" forState:UIControlStateNormal];
    [logout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)logout{
    
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:NO];
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
    return self.currentDirectory.name;
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

@end
