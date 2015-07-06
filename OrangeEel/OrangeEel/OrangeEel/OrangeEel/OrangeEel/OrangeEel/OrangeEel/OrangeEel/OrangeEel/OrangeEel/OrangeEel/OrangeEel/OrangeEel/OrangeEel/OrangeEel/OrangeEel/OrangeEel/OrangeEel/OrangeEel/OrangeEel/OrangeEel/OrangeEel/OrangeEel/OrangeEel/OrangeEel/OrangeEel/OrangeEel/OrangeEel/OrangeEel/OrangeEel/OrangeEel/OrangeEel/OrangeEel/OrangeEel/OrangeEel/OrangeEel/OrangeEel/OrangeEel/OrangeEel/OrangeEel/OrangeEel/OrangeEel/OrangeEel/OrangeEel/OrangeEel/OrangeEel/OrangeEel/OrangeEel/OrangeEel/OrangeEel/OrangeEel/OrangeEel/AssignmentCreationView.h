//
//  AssignmentCreationView.h
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/9/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assignment.h"
#import "MainViewController.h"
#import "AssignmentCreatorDelegate.h"
#import <MediaPlayer/MediaPlayer.h>


@protocol AssignmentCreatorDelegate <NSObject>

@optional
-(void)saveAssignment:(Assignment*)a;

@end

@interface AssignmentCreationView : UIView <UITextViewDelegate, UITextFieldDelegate, UIWebViewDelegate>
{
    
    
}
@property Assignment* myAssignment;

@property UIButton* cancelButton;
@property UIButton* saveButton;
@property UITextView* notes;
@property UITextField* focus1;
@property UITextField* focus2;
@property UITextField* focus3;
@property UITextField* focus4;
@property UITextField* focus5;
@property UITextField* extraMedia;
@property id <AssignmentCreatorDelegate> delegate;
@property UIScrollView* masterScroll;

@end
