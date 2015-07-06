//
//  AssignmentCreatorDelegate.h
//  OrangeEel
//
//  Created by Rolando Schneiderman on 6/9/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AssignmentCreatorDelegate <NSObject>

@optional
-(void)saveAssignment:(Assignment*)a;
-(void)removeAVC;
@end
