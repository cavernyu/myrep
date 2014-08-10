//
//  ViewController.m
//  PITax
//
//  Created by cavernyu on 14-8-4.
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
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for(int i = 0; i <= 20; i++){
//            NSLog(@"%i", i);
//        }
//    });
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 5.0);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"延时执行");
        
    });
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i <= 20; i++){
            NSLog(@"%i", i);
        }
    });
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"work1");
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"work2");
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"work3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"告诉主线程3个work都完成了");
    });
    
    self.textField.delegate = self;
    NSLog(@"second");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)calculate:(NSString*)revenue
{
    double value = [revenue doubleValue] - 3500;
    if(value <= 0){
        return @"0";
    }else if(value <= 1500 && value > 0){
        return [NSString stringWithFormat:@"%f", value*0.03];
    }else if(value <= 4500 && value > 1500){
        return [NSString stringWithFormat:@"%f", value*0.1];
    }else if(value <= 9000 && value > 4500){
        return [NSString stringWithFormat:@"%f", value*0.2];
    }else if(value <= 35000 && value > 9000){
        return [NSString stringWithFormat:@"%f", value*0.25];
    }else if(value <= 55000 && value > 35000){
        return [NSString stringWithFormat:@"%f", value*0.3];
    }else if(value <= 80000 && value > 55000){
        return [NSString stringWithFormat:@"%f", value*0.35];
    }else if(value > 80000){
        return [NSString stringWithFormat:@"%f", value*0.45];
    }else{
        return nil;
    }
}

- (IBAction)onclick:(id)sender {
    
    self.label.text = [NSString stringWithFormat:@"月收入总额:%@", [self calculate:self.textField.text]];
    self.textField.text = nil;
    
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    size_t numOfIter = 100;
//    dispatch_async(globalQueue, ^{
//        dispatch_apply(numOfIter, globalQueue, ^(size_t iter) {
//            NSLog(@"fuck GCD");
//        });
//    });
//    
//    NSURL *url = [NSURL URLWithString:@"http://www.51work6.com/ios_book_animals/animal-3.png"];
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.yuji.serialQueue", NULL);
//    dispatch_async(serialQueue, ^{
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:data];
//        dispatch_async(mainQueue, ^{
//            self.imageView.image = image;
//        });
//    });

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
