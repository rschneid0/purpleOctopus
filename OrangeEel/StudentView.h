//
//  StudentView.h
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/12/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol studentViewDelegate <NSObject>

@optional
-(void)hamburgerButton;

@end

@interface StudentView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    
}

@property UITableView* studentTableView;
@property id<studentViewDelegate> svd;
@end
