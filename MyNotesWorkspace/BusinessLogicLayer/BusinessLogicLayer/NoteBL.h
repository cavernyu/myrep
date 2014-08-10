//
//  NoteBL.h
//  BusinessLogicLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteDAO.h"

@interface NoteBL : NSObject

-(void)createNote:(Note *)model;

-(void)removeNoteAtindex:(NSInteger)index orById:(Note *)model;

-(NSMutableArray *)findAll;

@end
