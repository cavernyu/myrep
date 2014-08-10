//
//  NoteBL.m
//  BusinessLogicLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "NoteBL.h"

@implementation NoteBL

-(void)createNote:(Note *)model
{
    NoteDAO *noteDAO = [NoteDAO sharedNoteDAO];
    [noteDAO create:model];

}

-(void)removeNoteAtindex:(NSInteger)index orById:(Note *)model
{
    NoteDAO *noteDAO = [NoteDAO sharedNoteDAO];
    [noteDAO removeAtIndex:index orById:model];

}

-(NSMutableArray *)findAll
{
    NoteDAO *noteDAO = [NoteDAO sharedNoteDAO];
    return [noteDAO findAll];
}

@end
