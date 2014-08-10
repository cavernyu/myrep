//
//  MainDAO.m
//  PersistenceLayer
//
//  Created by cavernyu on 14-3-28.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "MainDAO.h"
@interface MainDAO()
-(void)createTableIfNeed:(NSString*)path;
@end

@implementation MainDAO

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(NSManagedObjectModel *)managedObjectModel
{
    if(_managedObjectModel){
        return _managedObjectModel;
    }
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"CoreDataNotes" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator){
        return _persistentStoreCoordinator;
    }
    NSURL *url = [[self applicationDocumentsDirectoryURL] URLByAppendingPathComponent:@"CoreDataNotes.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
    return _persistentStoreCoordinator;
}

-(NSManagedObjectContext*)managedObjectContext
{
    if(_managedObjectContext){
        return _managedObjectContext;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    return _managedObjectContext;
}


-(NSString *)applicationDocumentsDirectoryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSURL *)applicationDocumentsDirectoryURL
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)createTableIfNeed:(NSString *)path
{
    if(sqlite3_open([[[self applicationDocumentsDirectoryPath] stringByAppendingPathComponent:path] UTF8String], &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"SELECT COUNT(*) FROM SQLITE_MASTER WHERE TYPE = 'table' AND NAME = 'NOTE';";
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK){
            if(sqlite3_step(stmt) == SQLITE_ROW){
                int count = sqlite3_column_int(stmt, 0);
                if(count == 0){
                    NSString *createSql = @"CREATE TABLE IF NOT EXISTS NOTE (DATETIME TEXT PRIMARY KEY, TITLE TEXT, CONTENT TEXT);";
                    char *err;
                    if(sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                        NSAssert(NO, @"表NOTE创建失败:%s", err);
                    }
                }
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(db);
    }
}

-(BOOL)storeInFile:(NSString *)path archivedDateWithRootObject:(NSObject *)object
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    [data writeToFile:[[self applicationDocumentsDirectoryPath] stringByAppendingPathComponent:path] atomically:YES];
    return YES;
}

-(NSMutableArray *)readFromFile:(NSString *)path
{
    NSData *data = [NSData dataWithContentsOfFile:[[self applicationDocumentsDirectoryPath] stringByAppendingPathComponent:path]];
    
    NSMutableArray *resultList = (NSMutableArray*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return resultList;
}

-(BOOL)storeInSqlLite:(NSString *)path object:(id)object storeType:(int)type
{
    if(sqlite3_open([[[self applicationDocumentsDirectoryPath] stringByAppendingPathComponent:path] UTF8String], &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
        return YES;
    }else{
        sqlite3_stmt *stmt;
        if(type == 0){
            NSString *insertSql = @"INSERT OR REPLACE INTO NOTE (DATETIME, TITLE, CONTENT) VALUES (?, ?, ?);";
            if(sqlite3_prepare_v2(db, [insertSql UTF8String], -1, &stmt, NULL) == SQLITE_OK){
                Note *note = (Note*)object;
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
                NSString *datetime = [dateFormatter stringFromDate:note.date];
                NSString *title = note.title;
                NSString *content = note.content;
                
                sqlite3_bind_text(stmt, 1, [datetime UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [title UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 3, [content UTF8String], -1, NULL);
                
                if(sqlite3_step(stmt) != SQLITE_DONE){
                    NSAssert(NO, @"插入数据失败");
                }
            }
        }else if(type == 1){
            NSString *updateSql = @"UPDTAE NOTE SET TITLE = ?, CONTENT = ? WHERE DATETIME = ?;";
            if(sqlite3_prepare_v2(db, [updateSql UTF8String], -1, &stmt, NULL) == SQLITE_OK){
                Note *note = (Note*)object;
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
                NSString *datetime = [dateFormatter stringFromDate:note.date];
                NSString *title = note.title;
                NSString *content = note.content;
                
                sqlite3_bind_text(stmt, 3, [datetime UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 1, [title UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [content UTF8String], -1, NULL);
                
                if(sqlite3_step(stmt) != SQLITE_DONE){
                    NSAssert(NO, @"修改数据失败");
                }
            }
        }else{
            NSString *deleteSql = @"DELETE FROM NOTE WHERE DATETIME = ?;";
            if(sqlite3_prepare_v2(db, [deleteSql UTF8String], -1, &stmt, NULL) == SQLITE_OK){
                Note *note = (Note*)object;
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
                NSString *datetime = [dateFormatter stringFromDate:note.date];
                
                sqlite3_bind_text(stmt, 1, [datetime UTF8String], -1, NULL);
                
                if(sqlite3_step(stmt) != SQLITE_DONE){
                    NSAssert(NO, @"删除数据失败");
                }
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(db);
        return YES;
    }
}

-(NSMutableArray *)readFromSqlLite:(NSString *)path conditons:(NSDictionary *)conditions
{
//    [self createTableIfNeed:path];
    
    NSMutableArray *notes = [[NSMutableArray alloc] init];
    if(sqlite3_open([[[self applicationDocumentsDirectoryPath] stringByAppendingPathComponent:path] UTF8String], &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"SELECT COUNT(*) FROM SQLITE_MASTER WHERE TYPE = 'table' AND NAME = 'NOTE';";
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK){
            if(sqlite3_step(stmt) == SQLITE_ROW){
                int count = sqlite3_column_int(stmt, 0);
                if(count == 0){
                    NSString *createSql = @"CREATE TABLE IF NOT EXISTS NOTE (DATETIME TEXT PRIMARY KEY, TITLE TEXT, CONTENT TEXT);";
                    char *err;
                    if(sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                        NSAssert(NO, @"表NOTE创建失败:%s", err);
                    }
                }
            }
        }
        sqlite3_finalize(stmt);
        
        NSMutableString *querySql = [[NSMutableString alloc] initWithString:@"SELECT DATETIME, TITLE, CONTENT FROM NOTE"];
        if(!conditions || [[conditions allKeys] count] == 0){
            [querySql appendString:@" ORDER BY DATETIME ASC;"];
        }else{
            [querySql appendString:@" WHERE "];
            NSArray *keys = [conditions allKeys];
            for(id key in keys){
                NSString *conditionName = key;
                [querySql appendFormat:@"%@ = ? AND ", conditionName];
            }
            [querySql deleteCharactersInRange:NSMakeRange([querySql length] - 6, 5)];
            [querySql appendString:@" ORDER BY DATETIME ASC;"];
        }
        
        if(sqlite3_prepare_v2(db, [querySql UTF8String], -1, &stmt, NULL) == SQLITE_OK){
            if(conditions && [[conditions allKeys] count] > 0){
                NSArray *keys = [conditions allKeys];
                int i = 1;
                for(id key in keys){
                    NSString *conditionValue = [conditions objectForKey:key];
                    sqlite3_bind_text(stmt, i, [conditionValue UTF8String], -1, NULL);
                    i++;
                }
            }
            while(sqlite3_step(stmt) == SQLITE_ROW){
                char *datetime = (char*)sqlite3_column_text(stmt, 0);
                char *title = (char*)sqlite3_column_text(stmt, 1);
                char *content = (char*)sqlite3_column_text(stmt, 2);
                
                Note *note = [[Note alloc] init];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
                
                note.date = [dateFormatter dateFromString:[[NSString alloc] initWithCString:datetime encoding:NSUTF8StringEncoding]];
                note.title = [[NSString alloc] initWithCString:title encoding:NSUTF8StringEncoding];
                note.content = [[NSString alloc] initWithCString:content encoding:NSUTF8StringEncoding];
                
                [notes addObject:note];
            }
            sqlite3_finalize(stmt);
            sqlite3_close(db);
            return notes;
        }
        sqlite3_finalize(stmt);
        sqlite3_close(db);
    }
    return notes;
}

@end
