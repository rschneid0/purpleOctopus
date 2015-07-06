//
//  AssignmentCreationView.m
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/9/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import "AssignmentCreationView.h"

@implementation AssignmentCreationView
@synthesize  myAssignment, cancelButton, saveButton, focus1, focus2, focus3, focus4, focus5, extraMedia, notes, masterScroll;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        UITextField* newAssignmentLabel = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, 50)];
        
        masterScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [masterScroll setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height*2)];
        [self addSubview:masterScroll];
        //[newAssignmentLabel setBackgroundColor:[UIColor blueColor]];
        [newAssignmentLabel setTextAlignment:NSTextAlignmentCenter];
        //[newAssignmentLabel setText:@"New Assignment"];
        [newAssignmentLabel setPlaceholder:@"New Assignment"];
        [newAssignmentLabel setFont:[UIFont fontWithName:@"American Typewriter" size:33]];
        newAssignmentLabel.delegate=self;
        [masterScroll addSubview:newAssignmentLabel];
        
        NSLog(@"Custom inittttt");
        
        UILabel* notesLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, 100, 15)];
        [notesLabel setText:@"Notes:"];
        [notesLabel setTextColor:[UIColor blackColor]];
        [masterScroll addSubview:notesLabel];
        
        self.notes=  [[UITextView alloc] initWithFrame:CGRectMake(5, 80, self.frame.size.width-10, 70)];
        //[self.notes setBackgroundColor:[UIColor blackColor]];
        self.notes.layer.cornerRadius = 15.0f;
        self.notes.clipsToBounds=YES;
        [[self.notes layer] setBorderWidth:1.0f];
        [[self.notes layer] setBorderColor:[UIColor blackColor].CGColor];
        [masterScroll addSubview:self.notes];
        
        
        UILabel* focusLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 155, 300, 18)];
        [masterScroll addSubview:focusLabel];
        [focusLabel setText:@"Things to focus on..."];
        [focusLabel setTextColor:[UIColor blackColor]];
        
        
        focus1 = [[UITextField alloc] initWithFrame:CGRectMake(5, 175, self.frame.size.width-10, 30)];
        focus1.layer.cornerRadius = 10.0f;
        focus1.clipsToBounds=YES;
        focus1.delegate=self;
        [[focus1 layer] setBorderWidth:1.0f];
        [[focus1 layer] setBorderColor:[UIColor blackColor].CGColor];
        [masterScroll addSubview:focus1];
        
        focus2 = [[UITextField alloc] initWithFrame:CGRectMake(5, 210, self.frame.size.width-10, 30)];
        focus2.layer.cornerRadius = 10.0f;
        focus2.clipsToBounds=YES;
        focus2.delegate=self;
        [[focus2 layer] setBorderWidth:1.0f];
        [[focus2 layer] setBorderColor:[UIColor blackColor].CGColor];
        [masterScroll addSubview:focus2];
        
        focus3 = [[UITextField alloc] initWithFrame:CGRectMake(5, 245, self.frame.size.width-10, 30)];
        focus3.layer.cornerRadius = 10.0f;
        focus3.clipsToBounds=YES;
        focus3.delegate=self;
        [[focus3 layer] setBorderWidth:1.0f];
        [[focus3 layer] setBorderColor:[UIColor blackColor].CGColor];
        [masterScroll addSubview:focus3];
        
        
        extraMedia = [[UITextField alloc] initWithFrame:CGRectMake(5, 280, self.frame.size.width-20, 30)];
        extraMedia.layer.cornerRadius = 10.0f;
        extraMedia.clipsToBounds=YES;
        extraMedia.placeholder=@"Extra Media";
        extraMedia.delegate=self;
        extraMedia.tag=199;
        [[extraMedia layer] setBorderWidth:1.0f];
        [[extraMedia layer] setBorderColor:[UIColor blackColor].CGColor];
        [masterScroll addSubview:extraMedia];
        
        

        
        
        
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(5, self.frame.size.height-35, (self.frame.size.width/2)-10, 30)];
        cancelButton.layer.cornerRadius = 15.0f;
        cancelButton.clipsToBounds=YES;
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [[cancelButton layer] setBorderWidth:1.0f];
        [masterScroll addSubview:cancelButton];
        
        saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveButton setFrame:CGRectMake(5+self.frame.size.width/2, self.frame.size.height-35, (self.frame.size.width/2)-10, 30)];
        saveButton.layer.cornerRadius = 15.0f;
        saveButton.clipsToBounds=YES;
        [saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [saveButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [[saveButton layer] setBorderWidth:1.0f];
        [masterScroll addSubview:saveButton];

    }
        
        
    return self;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag==199) {
        
        NSString *videoID=[textField.text substringFromIndex:MAX((int)[textField.text length]-11, 0)]; //in case string is less than 4 characters long.
        NSLog(@"VURL: %@", videoID);
        NSString *videoURL = [NSString stringWithFormat:@"https://www.youtube.com/embed/%@",videoID];

        UIWebView *videoView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 280, self.frame.size.width-10, 200)];
        videoView.backgroundColor = [UIColor clearColor];
        videoView.opaque = NO;
        videoView.delegate = self;
        [masterScroll addSubview:videoView];
        
        
        
        NSString *videoHTML = [NSString stringWithFormat:@"\
                               <html>\
                               <head>\
                               <style type=\"text/css\">\
                               iframe {position:absolute; top:50%%; margin-top:-130px;}\
                               body {background-color:#000; margin:0;}\
                               </style>\
                               </head>\
                               <body>\
                               <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
                               </body>\
                               </html>", videoURL];
        
        [videoView loadHTMLString:videoHTML baseURL:nil];

    }
    [textField resignFirstResponder];
    return YES;
}
-(void)cancelButtonPressed{
    [self.delegate removeAVC];
}
-(void)saveButtonPressed{
    
    myAssignment = [Assignment MR_createEntity];
    myAssignment.notes=self.notes.text;
    //a.container=d;
    //[d addContentsAObject:a];
    NSLog(@"Running");
    [self.delegate saveAssignment:myAssignment];
    [self.delegate removeAVC];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
