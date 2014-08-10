//
//  UploadViewController.m
//  XMLParse
//
//  Created by cavernyu on 14-6-3.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

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

- (IBAction)upload:(id)sender {
    NSString *urlStr = @"http://iosbook1.com/service/upload.php";
    NSURL *url = [NSURL URLWithString:[urlStr URLEncodingString]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:@"cavernyu@126.com" forKey:@"email"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"jpg"];
    [request setPostValue:path forKey:@"file"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
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
        NSString *urlStr = @"http://iosbook1.com/service/download.php";
        NSURL *url = [NSURL URLWithString:[urlStr URLEncodingString]];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request setPostValue:@"cavernyu@126.com" forKey:@"email"];
        [request setPostValue:@"FileName" forKey:@"1.jpg"];
        
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(requestDidFinish:)];
        [request setDidFailSelector:@selector(requestDidFail:)];
        [request startAsynchronous];
        


    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@", [request.error localizedDescription]);
}


-(void)requestDidFinish:(ASIHTTPRequest *)request
{
    NSData *responseData = request.responseData;
    if(responseData){
        self.imageView.image = [UIImage imageWithData:responseData];
    }
    
}

-(void)requestDidFail:(ASIHTTPRequest *)request
{
    NSLog(@"%@", [request.error localizedDescription]);
}



@end
