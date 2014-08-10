//
//  NoteManagedObject.h
//  PersistenceLayer
//
//  Created by cavernyu on 14-5-15.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * datetime;

@end
