//
//  Directory.h
//  
//
//  Created by Rolando Schneiderman on 6/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Assignment, Directory;

@interface Directory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Directory *container;
@property (nonatomic, retain) NSSet *contentsA;
@property (nonatomic, retain) NSSet *contentsD;
@end

@interface Directory (CoreDataGeneratedAccessors)

- (void)addContentsAObject:(Assignment *)value;
- (void)removeContentsAObject:(Assignment *)value;
- (void)addContentsA:(NSSet *)values;
- (void)removeContentsA:(NSSet *)values;

- (void)addContentsDObject:(Directory *)value;
- (void)removeContentsDObject:(Directory *)value;
- (void)addContentsD:(NSSet *)values;
- (void)removeContentsD:(NSSet *)values;

@end
