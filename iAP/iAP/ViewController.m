//
//  ViewController.m
//  iAP
//
//  Created by cavernyu on 14-7-31.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.priceFormatter = [[NSNumberFormatter alloc] init];
    [self.priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [self.priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProductIdentifiers" ofType:@"plist"];
    NSArray *tmpArr = [NSArray arrayWithContentsOfFile:path];
    self.productIDs = [NSSet setWithArray:tmpArr];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i = 0;
    int j = 1;
    i += j;
    DLog(@"i=%i", i);
    int a = 1;
    int b = 2;
    a = [self ccount:a and:b];
    DLog(@"a=%i", a);
    DLog(@"%@", self.skProducts == nil?@"nil":[NSString stringWithFormat:@"%lu", (unsigned long)self.skProducts.count]);
    NSAssert1(self.skProducts != nil && self.skProducts.count > 0, @"断言产品数组不为空并且数组成员数大于0，结果产品数组:%@", self.skProducts);

    return [self.skProducts count];
}

-(int)ccount:(int)a and:(int)b
{
    a += b;
    for(;a<=10;a++){
        
    }
    return a;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    SKProduct *product = [self.skProducts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = product.localizedTitle;
    [self.priceFormatter setLocale:product.priceLocale];
    cell.detailTextLabel.text = [self.priceFormatter stringFromNumber:product.price];
    BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:product.productIdentifier];
    if(productPurchased){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
    }else{
        UIImage *buttonUpImage = [UIImage imageNamed:@"button_up.png"];
        UIImage *buttonDownImage = [UIImage imageNamed:@"button_down.png"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, buttonUpImage.size.width, buttonUpImage.size.height);
        [button setBackgroundImage:buttonUpImage forState:UIControlStateNormal];
        [button setBackgroundImage:buttonDownImage forState:UIControlStateHighlighted];
        
        [button setTitle:@"购买" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = indexPath.row;
        
        cell.accessoryView = button;
    }
    
    return cell;
}

-(void)buttonTapped:(id)sender
{
    UIButton *button = (UIButton*)sender;
    SKProduct *product = self.skProducts[button.tag];
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (IBAction)restore:(id)sender {
    self.navigationItem.prompt = nil;
    self.refreshButton.enabled = NO;
    self.restoreButton.enabled = NO;
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (IBAction)refresh:(id)sender {
    if([SKPaymentQueue canMakePayments]){
        SKProductsRequest *skRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:self.productIDs];
        skRequest.delegate = self;
        [skRequest start];
        
        self.navigationItem.prompt = @"刷新中";
        self.refreshButton.enabled = NO;
        self.restoreButton.enabled = NO;
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"访问限制" message:@"不能进行应用内购买" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    self.navigationItem.prompt = nil;
    self.restoreButton.enabled = YES;
    self.refreshButton.enabled = YES;
    
    self.skProducts = response.products;
    for(SKProduct *product in self.skProducts){
        NSLog(@"找到产品:%@ %@ %0.2f", product.productIdentifier, product.localizedTitle, product.price.floatValue);
    }
    [self.tableView reloadData];
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for(SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

-(void)completeTransaction:(SKPaymentTransaction*) transaction
{
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)provideContentForProductIdentifier:(NSString*)productIdentifer
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifer];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

-(void)restoreTransaction:(SKPaymentTransaction*) transaction
{
    self.navigationItem.prompt = nil;
    self.restoreButton.enabled = YES;
    self.refreshButton.enabled = YES;
    
    [self provideContentForProductIdentifier:transaction.originalTransaction. payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)failedTransaction:(SKPaymentTransaction*) transaction
{
    if(transaction.error.code != SKErrorPaymentCancelled){
        NSLog(@"交易失败:%@", transaction.error.localizedDescription);
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

@end
