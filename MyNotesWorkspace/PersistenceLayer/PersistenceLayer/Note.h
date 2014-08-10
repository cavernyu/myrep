//
//  Note.h
//  PersistenceLayer
//
//  Created by cavernyu on 14-3-27.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject<NSCoding>
{
    NSString *_title;
    
    NSString *_content;
    
    NSDate *_date;
}

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *content;

@property (strong, nonatomic) NSDate *date;



@end
