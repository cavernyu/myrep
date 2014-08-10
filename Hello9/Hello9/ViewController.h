//
//  ViewController.h
//  Hello9
//
//  Created by cavernyu on 13-11-12.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *events;

@end
