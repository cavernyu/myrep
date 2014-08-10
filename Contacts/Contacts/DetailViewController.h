//
//  DetailViewController.h
//  ReadContacts
//
//  Created by cavernyu on 14-5-16.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *personImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tel1;
@property (weak, nonatomic) IBOutlet UILabel *tel2;
@property (weak, nonatomic) IBOutlet UILabel *email1;
@property (weak, nonatomic) IBOutlet UILabel *email2;

- (IBAction)back:(id)sender;

@end
