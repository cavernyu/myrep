//
//  MainDAO.h
//  PersistenceLayer
//
//  Created by cavernyu on 14-3-28.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <sqlite3.h>
#import "Note.h"

@interface MainDAO : NSObject
{
    sqlite3 *db;
    NSManagedObjectModel *_managedObjectModel;
    NSManagedObjectContext *_managedObjectContext;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property (readonly, nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (readonly , nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
-(NSString*)applicationDocumentsDirectoryPath;

-(NSURL*)applicationDocumentsDirectoryURL;

-(BOOL)storeInFile:(NSString *)path archivedDateWithRootObject:(NSObject *)object;

-(NSMutableArray *)readFromFile:(NSString *)path;

-(BOOL)storeInSqlLite:(NSString *)path object:(id)object storeType:(int)type;

-(NSMutableArray *)readFromSqlLite:(NSString *)path conditons:(NSDictionary*)conditions;

@end
