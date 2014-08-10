//
//  Item.h
//  hello
//
//  Created by cavernyu on 13-10-23.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
{
    NSString *_itemName;
    NSUInteger _itemID;
    float _score;
}
@property (nonatomic, retain) NSString *itemName;
@property (nonatomic, assign) NSUInteger itemID;
@property (nonatomic, assign) float score;


@end
