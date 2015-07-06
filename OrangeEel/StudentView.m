//
//  StudentView.m
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/12/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import "StudentView.h"

@implementation StudentView
{
    
}
@synthesize studentTableView;
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor=[UIColor blackColor];
        studentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.frame.size.width, self.frame.size.height-65)];
        studentTableView.delegate=self;
        studentTableView.dataSource=self;
        [self addSubview:studentTableView];
        
        UIButton* hamburgerButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [hamburgerButton2 setFrame:CGRectMake(0, 10, 65, 55)];
        [hamburgerButton2 setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
        [hamburgerButton2.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [hamburgerButton2 addTarget:self action:@selector(openDrawer) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hamburgerButton2];

    }
    return self;
}

-(void)openDrawer{
    [self.svd hamburgerButton];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;    //count number of row from counting array hear cataGorry is An Array
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Students";
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
    cell.textLabel.text = @"No Students Yet!";
    return cell;
}

@end
