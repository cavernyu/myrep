//
//  NoteDAO.h
//  PersistenceLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainDAO.h"
#import "Note.h"
#import "NoteManagedObject.h"

@interface NoteDAO : MainDAO

@property (strong, nonatomic) NSMutableArray *listData;

+(NoteDAO *)sharedNoteDAO;

-(int)create:(Note *)model;

-(int)removeAtIndex:(NSInteger)index orById:(Note *)model;

-(int)modify:(Note *)model;

-(NSMutableArray *)findAll;

-(Note *)findById:(Note *)model;

@end
