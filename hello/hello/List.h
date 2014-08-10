//
//  List.h
//  hello
//
//  Created by cavernyu on 13-10-23.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface List : NSObject
{
    NSMutableArray *_itemList;
}
@property (nonatomic, retain) NSMutableArray *itemList;

@end
