//
//  Note.h
//  XMLParse
//
//  Created by cavernyu on 14-5-29.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userID;
@end
