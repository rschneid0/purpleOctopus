//
//  NewEventView.m
//  
//
//  Created by Rolando Schneiderman on 6/17/15.
//
//

#import "NewEventView.h"

@implementation NewEventView
@synthesize mainTableView;

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel* newEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-100, 20, 200, 45)];
        [newEventLabel setText:@"New Event"];
        [newEventLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:newEventLabel];
        
        UIButton* backButton = [ UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 15, 65, 50)];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        
        UIButton* addEvent = [ UIButton buttonWithType:UIButtonTypeCustom];
        [addEvent setFrame:CGRectMake(frame.size.width-85, 15, 85, 50)];
        [addEvent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addEvent setTitle:@"Add Event" forState:UIControlStateNormal];
        [addEvent addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addEvent];
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
        mainTableView.delegate=self;
        mainTableView.dataSource=self;
        [self addSubview:mainTableView];
    }
    
    return self;
}

-(void)backButton{
    [self removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }
    if (section==1) {
        return 4;
    }
    return 2;    //count number of row from counting array hear cataGorry is An Array
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
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    cell.textLabel.text = @"My Text";
    return cell;
}

@end
