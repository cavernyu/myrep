//
//  ViewController.h
//  iAP
//
//  Created by cavernyu on 14-7-31.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *restoreButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *skProducts;
@property (nonatomic, strong) NSSet *productIDs;
@property (nonatomic, strong) NSNumberFormatter *priceFormatter;

- (IBAction)restore:(id)sender;
- (IBAction)refresh:(id)sender;

@end
