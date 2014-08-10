//
//  ImageViewController.m
//  XMLParse
//
//  Created by cavernyu on 14-6-2.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)go:(id)sender {
    if(!self.queue){
        self.queue = [[ASINetworkQueue alloc] init];
    }
    
    [self.queue cancelAllOperations];
    [self.queue setDelegate:self];
    [self.queue setRequestDidFinishSelector:@selector(requestFinished:)];
    [self.queue setRequestDidFailSelector:@selector(requestFailed:)];
    [self.queue setQueueDidFinishSelector:@selector(queueFinished:)];
    
    for(int i = 1; i < 3; i++){
        NSString *urlStr = [NSString stringWithFormat:@"http://iosbook1.com/service/download.php?email=%@&FileName=test%i.jpg", @"cavernyu@126.com", i];
        NSURL *url = [NSURL URLWithString:[urlStr URLEncodingString]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        request.tag = i;
        [self.queue addOperation:request];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.queue go];
    
}

-(void)requestFinished:(ASIHTTPRequest*)request
{
    NSData *responseData = request.responseData;
    NSError *err;
    NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
    
    if(dict1){
        NSNumber *num = [dict1 objectForKey:@"ResultCode"];
        if(num){
            int code = [num intValue];
            if(code == -1){
                NSLog(@"用户不存在");
            }else if(code == -2){
                NSLog(@"您的账号最多能插入10条数据");
            }else if(code == -3){
                NSLog(@"数据访问失败");
            }else if(code == -4){
                NSLog(@"ID没有输入");
            }else if(code == -5){
                NSLog(@"内容没有输入");
            }else if(code == -6){
                NSLog(@"日期没有输入");
            }else if(code == -7){
                NSLog(@"没有数据");
            }else{
                NSLog(@"错误码:%i", code);
            }
        }
    }else{
        UIImage *img = [UIImage imageWithData:responseData];
        if(request.tag == 1){
            self.imageView1.image = img;
        }else{
            self.imageView2.image = img;
        }
    }
    if(self.queue.requestsCount == 0){
        self.queue = nil;
    }
    
}

-(void)requestFailed:(ASIHTTPRequest*)request
{
    NSError *err = request.error;
    NSLog(@"%@", [err localizedDescription]);
    if(self.queue.requestsCount == 0){
        self.queue = nil;
    }
}

-(void)queueFinished:(ASINetworkQueue*)queue
{
    if(self.queue.requestsCount == 0){
        self.queue = nil;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}


@end
