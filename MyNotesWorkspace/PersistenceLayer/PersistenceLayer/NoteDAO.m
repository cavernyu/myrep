//
//  NoteDAO.m
//  PersistenceLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "NoteDAO.h"

#define ARCHIVE_PATH @"myNotes"
#define SQLITE3_PATH @"sqlite3_db"
@interface NoteDAO()
-(NSString*)getStoreType;
@end

@implementation NoteDAO
static NoteDAO *sharedManager;
+(NoteDAO *)sharedNoteDAO
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

-(NSString *)getStoreType
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"storeType_preference"];
}

-(int)create:(Note *)model
{
    if([[self getStoreType] isEqualToString:@"归档"]){
        self.listData = [self findAll];
        if(!self.listData){
            self.listData = [[NSMutableArray alloc] init];
        }
        [self.listData addObject:model];
        [self storeInFile:ARCHIVE_PATH archivedDateWithRootObject:self.listData];
    }else if([[self getStoreType] isEqualToString:@"数据库"]){
        [self storeInSqlLite:SQLITE3_PATH object:model storeType:0];
    }else{
        NSManagedObjectContext *moc = self.managedObjectContext;
        
        NoteManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc];
        obj.title = model.title;
        obj.content = model.content;
        obj.datetime = model.date;
        
        NSError *err;
        if([moc save:&err]){
            NSLog(@"插入数据成功");
        }else{
            NSLog(@"插入数据失败");
            return -1;
        }
    }
    
    return 0;
}

-(int)removeAtIndex:(NSInteger)index orById:(Note *)model
{
    if([[self getStoreType] isEqualToString:@"归档"]){
        self.listData = [self findAll];
        [self.listData removeObjectAtIndex:index];
        [self storeInFile:ARCHIVE_PATH archivedDateWithRootObject:self.listData];
    }else if([[self getStoreType] isEqualToString:@"数据库"]){
        [self storeInSqlLite:SQLITE3_PATH object:model storeType:3];
    }else{
        NSManagedObjectContext *moc = self.managedObjectContext;
        
        NSEntityDescription *entityNote = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityNote];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"datetime = %@", model.date];
        [request setPredicate:predicate];
        
        NSError *err;
        NSArray *noteList = [moc executeFetchRequest:request error:&err];
        if([noteList count] > 0){
            NoteManagedObject *obj = [noteList lastObject];
            [moc deleteObject:obj];
            
            NSError *saveErr;
            if([moc save:&saveErr]){
                NSLog(@"删除数据成功");
            }else{
                NSLog(@"删除数据失败");
                return -1;
            }
        }
        
    }
    return 0;
}

-(int)modify:(Note *)model
{
    if([[self getStoreType] isEqualToString:@"归档"]){
        self.listData = [self findAll];
        for(Note *note in self.listData){
            if([note.date isEqualToDate:model.date]){
                note.title = model.title;
                note.content = model.content;
                break;
            }
        }
        [self storeInFile:ARCHIVE_PATH archivedDateWithRootObject:self.listData];
    }else if([[self getStoreType] isEqualToString:@"数据库"]){
        [self storeInSqlLite:SQLITE3_PATH object:model storeType:1];
    }else{
        NSManagedObjectContext *moc = self.managedObjectContext;
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityNote = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc];
        [request setEntity:entityNote];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"datetime = %@", model.date];
        [request setPredicate:predicate];
        
        NSError *err;
        NSArray *noteList = [moc executeFetchRequest:request error:&err];
        if([noteList count] > 0){
            NoteManagedObject *obj = [noteList lastObject];
            obj.title = model.title;
            obj.content = model.content;
            
            NSError *saveErr;
            if([moc save:&saveErr]){
                NSLog(@"修改数据成功");
            }else{
                NSLog(@"修改数据失败");
                return -1;
            }
        }
    }
    
    
    return 0;
}

-(Note *)findById:(Note *)model
{
    if([[self getStoreType] isEqualToString:@"归档"]){
        self.listData = [self findAll];
        for(Note *note in self.listData){
            if([note.date isEqualToDate:model.date]){
                return note;
            }
        }
    }else if([[self getStoreType] isEqualToString:@"数据库"]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
        NSMutableArray *notes = [self readFromSqlLite:SQLITE3_PATH conditons:@{@"DATETIME": [dateFormatter stringFromDate:model.date]}];
        return [notes objectAtIndex:0];
    }else{
        NSManagedObjectContext *moc = self.managedObjectContext;
        
        NSFetchRequest *request =[[NSFetchRequest alloc] init];
        NSEntityDescription *entityNote = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc];
        [request setEntity:entityNote];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"datetime = %@", model.date];
        [request setPredicate:predicate];
        
        NSError *err;
        NSArray *noteList = [moc executeFetchRequest:request error:&err];
        if([noteList count] > 0){
            NoteManagedObject *obj = [noteList lastObject];
            Note *note = [[Note alloc] init];
            note.title = obj.title;
            note.content = obj.content;
            note.date = obj.datetime;
            return note;
        }
    }
    
    return nil;
}

-(NSMutableArray *)findAll
{
    if([[self getStoreType] isEqualToString:@"归档"]){
        return [self readFromFile:ARCHIVE_PATH];
    }else if([[self getStoreType] isEqualToString:@"数据库"]){
        return [self readFromSqlLite:SQLITE3_PATH conditons:nil];
    }else{
        NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
        
        NSEntityDescription *entityNote = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityNote];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datetime" ascending:YES];
        [request setSortDescriptors:@[sortDescriptor]];
        
        NSError *err;
        NSArray *noteList = [managedObjectContext executeFetchRequest:request error:&err];
        
        NSMutableArray *notes = [[NSMutableArray alloc] initWithCapacity:[noteList count]];
        for(NoteManagedObject *obj in noteList){
            Note *note = [[Note alloc] init];
            note.title = obj.title;
            note.content = obj.content;
            note.date = obj.datetime;
            [notes addObject:note];
        }
        return notes;
    }
    
}

@end
