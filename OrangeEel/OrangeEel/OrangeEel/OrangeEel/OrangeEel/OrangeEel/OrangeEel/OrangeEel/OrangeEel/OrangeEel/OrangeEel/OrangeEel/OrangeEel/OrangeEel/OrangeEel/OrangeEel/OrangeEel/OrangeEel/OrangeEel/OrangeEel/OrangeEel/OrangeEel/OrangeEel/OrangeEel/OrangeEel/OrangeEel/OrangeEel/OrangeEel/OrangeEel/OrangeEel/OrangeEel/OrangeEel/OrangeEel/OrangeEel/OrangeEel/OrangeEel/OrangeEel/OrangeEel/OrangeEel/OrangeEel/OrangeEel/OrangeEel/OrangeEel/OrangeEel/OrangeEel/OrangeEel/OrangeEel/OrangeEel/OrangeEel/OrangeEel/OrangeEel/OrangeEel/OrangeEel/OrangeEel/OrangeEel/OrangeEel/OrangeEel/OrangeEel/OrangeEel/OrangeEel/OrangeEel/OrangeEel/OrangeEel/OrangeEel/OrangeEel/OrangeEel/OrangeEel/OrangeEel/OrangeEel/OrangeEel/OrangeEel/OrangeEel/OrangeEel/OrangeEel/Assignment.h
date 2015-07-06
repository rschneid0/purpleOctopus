//
//  Assignment.h
//  
//
//  Created by Rolando Schneiderman on 6/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Directory;

@interface Assignment : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * focus1;
@property (nonatomic, retain) NSString * focus2;
@property (nonatomic, retain) NSString * focus3;
@property (nonatomic, retain) NSString * focus4;
@property (nonatomic, retain) NSString * focus5;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * media;
@property (nonatomic, retain) Directory *container;

@end
