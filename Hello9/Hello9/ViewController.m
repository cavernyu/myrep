//
//  ViewController.m
//  Hello9
//
//  Created by cavernyu on 13-11-12.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"events" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    self.events = array;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if([self.events count]%2 == 1){
        return [self.events count]/2 + 1 ;
    }else{
        return [self.events count]/2;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([self.events count] == 0)
        return 0;
    if([self.events count]%2 == 1&& section == [self.events count]/2){
            return 1;
    }
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *event = [self.events objectAtIndex:(indexPath.section*2+indexPath.row)];
    cell.label.text = [event objectForKey:@"name"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[event objectForKey:@"name"] ofType:@"gif"]];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = [self.events objectAtIndex:(indexPath.section*2+indexPath.row)];
    NSLog(@"%@", [event objectForKey:@"name"]);
}

@end
