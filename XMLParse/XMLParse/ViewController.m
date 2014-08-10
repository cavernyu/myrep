//
//  ViewController.m
//  XMLParse
//
//  Created by cavernyu on 14-5-29.
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)xmlParseNSXML:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.notes = [[NSMutableArray alloc] init];
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.currentElementName = elementName;
    if([elementName isEqualToString:@"Note"]){
        self.note = [[Note alloc] init];
        NSString *identifier =[attributeDict objectForKey:@"id"];
        self.note.identifier = [NSString stringWithFormat:@"%@%@", elementName, !identifier?@"":identifier];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(string){
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([string isEqualToString:@""]){
        return;
    }

    if([self.currentElementName isEqualToString:@"CDate"] && self.note){
        self.note.date = string;
    }
    if([self.currentElementName isEqualToString:@"Content"] && self.note){
        self.note.content = string;
    }
    if([self.currentElementName isEqualToString:@"UserID"] && self.note){
        self.note.userID = string;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"Note"]){
        [self.notes addObject:self.note];
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    if(!self.notesViewController){
        self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    }
    
    self.notesViewController.notes = self.notes;
    [self.navigationController pushViewController:self.notesViewController animated:YES];
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@", parseError);
}


- (IBAction)xmlParse_TBXML:(id)sender {
    self.notes = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    TBXML *tbXML = [[TBXML alloc] initWithXMLData:data error:nil];
    TBXMLElement *rootElement = tbXML.rootXMLElement;
    if(rootElement){
        TBXMLElement *noteElement = [TBXML childElementNamed:@"Note" parentElement:rootElement];
        while(noteElement){
            Note *note = [[Note alloc] init];
            NSString *identifier = [TBXML valueOfAttributeNamed:@"id" forElement:noteElement error:nil];
            note.identifier = [NSString stringWithFormat:@"Note%@", !identifier?@"":identifier];
            
            TBXMLElement *cdateElement = [TBXML childElementNamed:@"CDate" parentElement:noteElement];
            if(cdateElement){
                NSString *cdate = [TBXML textForElement:cdateElement];
                note.date = !cdate?@"":cdate;
            }
            TBXMLElement *contentElement = [TBXML childElementNamed:@"Content" parentElement:noteElement];
            if(contentElement){
                NSString *content = [TBXML textForElement:contentElement];
                note.content = !content?@"":content;
            }
            TBXMLElement *userIDElement = [TBXML childElementNamed:@"UserID" parentElement:noteElement];
            if(contentElement){
                NSString *userID = [TBXML textForElement:userIDElement];
                note.userID = !userID?@"":userID;
            }
            
            [self.notes addObject:note];
            
            noteElement = [TBXML nextSiblingNamed:@"Note" searchFromElement:noteElement];
        }
    }
    if(!self.notesViewController){
        self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    }
    self.notesViewController.notes = self.notes;
    [self.navigationController pushViewController:self.notesViewController animated:YES];
}

- (IBAction)parseJSON:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
    if(!obj || err){
        NSLog(@"json解析失败:%@", err);
    }else{
        NSArray *arr = [obj objectForKey:@"Notes"];
        if(arr){
            self.notes = [[NSMutableArray alloc] init];
            for(NSDictionary *dict in arr){
                if(dict){
                    Note *note = [[Note alloc] init];
                    NSString *identifier = [dict objectForKey:@"id"];
                    NSString *content = [dict objectForKey:@"Content"];
                    NSString *cdate = [dict objectForKey:@"CDate"];
                    NSString *userID = [dict objectForKey:@"UserID"];
                    note.identifier = [NSString stringWithFormat:@"Note%@", identifier?identifier:@""];
                    note.content = content?content:@"";
                    note.date = cdate?cdate:@"";
                    note.userID = userID?userID:@"";
                    [self.notes addObject:note];
                }
            }
        }
    }
    if(!self.notesViewController){
        self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    }
    self.notesViewController.notes = self.notes;
    [self.navigationController pushViewController:self.notesViewController animated:YES];
    
    
}


- (IBAction)synchronousGet:(id)sender {
    NSString *urlString = [NSString stringWithFormat:@"http://iosbook1.com/service/mynotes/webservice.php?email=%@&type=%@&action=%@", @"cavernyu@126.com", @"JSON", @"query"];
    NSURL *url = [NSURL URLWithString:[urlString URLEncodingString]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
//    NSError *err;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
//    NSLog(@"%@", data?@"请求完成":err);
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if(dict1){
            NSNumber *num = [dict1 objectForKey:@"ResultCode"];
            if(num){
                int code = [num intValue];
                if(code == 0){
                    self.notes = [[NSMutableArray alloc] init];
                    NSArray *arr = [dict1 objectForKey:@"Record"];
                    if(arr){
                        NSDictionary *dict2 = [arr lastObject];
                        if(dict2){
                            Note *note = [[Note alloc] init];
                            NSString *identfier = [dict2 objectForKey:@"ID"];
                            NSString *cdate = [dict2 objectForKey:@"CDate"];
                            NSString *content = [dict2 objectForKey:@"Content"];
                            NSString *userID = [dict2 objectForKey:@"UserID"];
                            note.identifier = identfier?[NSString stringWithFormat:@"Note%@", identfier]:@"";
                            note.date = cdate?cdate:@"";
                            note.content = content?content:@"";
                            note.userID = userID?userID:@"";
                            [self.notes addObject:note];
                        }
                    }
                }
                else if(code == -1){
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
        }
    }];

   
    if(!self.notesViewController){
        self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    }
    self.notesViewController.notes = self.notes;
    [self.navigationController pushViewController:self.notesViewController animated:YES];
}

- (IBAction)asynchronousGet:(id)sender {
    NSString *urlStr = [NSString stringWithFormat:@"http://iosbook1.com/service/mynotes/webservice.php?email=%@&type=%@&action=%@", @"cavernyu@126.com", @"JSON", @"query"];
    NSURL *url = [NSURL URLWithString:[urlStr URLEncodingString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn){
        self.data = [[NSMutableData alloc] init];
    }
}

- (IBAction)asynchronousPost:(id)sender {
    NSString *urlStr = @"http://iosbook1.com/service/mynotes/webservice.php";
    NSURL *url = [NSURL URLWithString:[urlStr URLEncodingString]];
    
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"cavernyu@126.com", @"JSON", @"query"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(conn){
        self.data = [[NSMutableData alloc] init];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"连接失败:%@", error);
    self.notes = [[NSMutableArray alloc] init];
    if(!self.notesViewController){
        self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    }
    self.notesViewController.notes = self.notes;
    [self.navigationController pushViewController:self.notesViewController animated:YES];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingAllowFragments error:nil];
    
    if(dict1){
        NSNumber *num = [dict1 objectForKey:@"ResultCode"];
        if(num){
            int code = [num intValue];
            if(code == 0){
                self.notes = [[NSMutableArray alloc] init];
                NSArray *arr = [dict1 objectForKey:@"Record"];
                if(arr){
                    NSDictionary *dict2 = [arr lastObject];
                    if(dict2){
                        Note *note = [[Note alloc] init];
                        NSString *identfier = [dict2 objectForKey:@"ID"];
                        NSString *cdate = [dict2 objectForKey:@"CDate"];
                        NSString *content = [dict2 objectForKey:@"Content"];
                        NSString *userID = [dict2 objectForKey:@"UserID"];
                        note.identifier = identfier?[NSString stringWithFormat:@"Note%@", identfier]:@"";
                        note.date = cdate?cdate:@"";
                        note.content = content?content:@"";
                        note.userID = userID?userID:@"";
                        [self.notes addObject:note];
                    }
                }
            }
            else if(code == -1){
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
    }
    if(!self.notesViewController){
        self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    }
    self.notesViewController.notes = self.notes;
    [self.navigationController pushViewController:self.notesViewController animated:YES];
}

- (IBAction)synGetASIHTTPRequest:(id)sender {
    NSString *urlStr = [NSString stringWithFormat:@"http://iosbook1.com/service/mynotes/webservice.php?email=%@&type=%@&action=%@", @"cavernyu@126.com", @"JSON", @"query"];
    NSURL *url = [NSURL URLWithString:[urlStr URLEncodingString]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *err = request.error;
    if(!err){
        NSData *responseData = request.responseData;
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        
        if(dict1){
            NSNumber *num = [dict1 objectForKey:@"ResultCode"];
            if(num){
                int code = [num intValue];
                if(code == 0){
                    self.notes = [[NSMutableArray alloc] init];
                    NSArray *arr = [dict1 objectForKey:@"Record"];
                    if(arr){
                        NSDictionary *dict2 = [arr lastObject];
                        if(dict2){
                            Note *note = [[Note alloc] init];
                            NSString *identfier = [dict2 objectForKey:@"ID"];
                            NSString *cdate = [dict2 objectForKey:@"CDate"];
                            NSString *content = [dict2 objectForKey:@"Content"];
                            NSString *userID = [dict2 objectForKey:@"UserID"];
                            note.identifier = identfier?[NSString stringWithFormat:@"Note%@", identfier]:@"";
                            note.date = cdate?cdate:@"";
                            note.content = content?content:@"";
                            note.userID = userID?userID:@"";
                            [self.notes addObject:note];
                        }
                    }
                }
                else if(code == -1){
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
        }
        if(!self.notesViewController){
            self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
        }
        self.notesViewController.notes = self.notes;
        [self.navigationController pushViewController:self.notesViewController animated:YES];
    }else{
        NSLog(@"%@", err);
    }
    
}

- (IBAction)synPostASIHTTPRequest:(id)sender {
    NSString *urlStr = @"http://iosbook1.com/service/mynotes/webservice.php";
    NSURL *url = [NSURL URLWithString:[urlStr URLEncodingString]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:@"cavernyu@126.com" forKey:@"email"];
    [request setPostValue:@"JSON" forKey:@"type"];
    [request setPostValue:@"query" forKey:@"action"];
    [request startSynchronous];
    NSError *err = request.error;
    if(!err){
        NSData *responseData = request.responseData;
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        
        if(dict1){
            NSNumber *num = [dict1 objectForKey:@"ResultCode"];
            if(num){
                int code = [num intValue];
                if(code == 0){
                    self.notes = [[NSMutableArray alloc] init];
                    NSArray *arr = [dict1 objectForKey:@"Record"];
                    if(arr){
                        NSDictionary *dict2 = [arr lastObject];
                        if(dict2){
                            Note *note = [[Note alloc] init];
                            NSString *identfier = [dict2 objectForKey:@"ID"];
                            NSString *cdate = [dict2 objectForKey:@"CDate"];
                            NSString *content = [dict2 objectForKey:@"Content"];
                            NSString *userID = [dict2 objectForKey:@"UserID"];
                            note.identifier = identfier?[NSString stringWithFormat:@"Note%@", identfier]:@"";
                            note.date = cdate?cdate:@"";
                            note.content = content?content:@"";
                            note.userID = userID?userID:@"";
                            [self.notes addObject:note];
                        }
                    }
                }
                else if(code == -1){
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
        }
        if(!self.notesViewController){
            self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
        }
        self.notesViewController.notes = self.notes;
        [self.navigationController pushViewController:self.notesViewController animated:YES];
    }else{
        NSLog(@"%@", err);
    }
}

- (IBAction)asynGetASIHTTPRequest:(id)sender {
    NSString *urlStr = [NSString stringWithFormat:@"http://iosbook1.com/service/mynotes/webservice.php?email=%@&type=%@&action=%@", @"cavernyu@126.com", @"JSON", @"query"];
    NSURL *url = [NSURL URLWithString:[urlStr URLEncodingString]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = request.responseData;
    NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    
    if(dict1){
        NSNumber *num = [dict1 objectForKey:@"ResultCode"];
        if(num){
            int code = [num intValue];
            if(code == 0){
                self.notes = [[NSMutableArray alloc] init];
                NSArray *arr = [dict1 objectForKey:@"Record"];
                if(arr){
                    NSDictionary *dict2 = [arr lastObject];
                    if(dict2){
                        Note *note = [[Note alloc] init];
                        NSString *identfier = [dict2 objectForKey:@"ID"];
                        NSString *cdate = [dict2 objectForKey:@"CDate"];
                        NSString *content = [dict2 objectForKey:@"Content"];
                        NSString *userID = [dict2 objectForKey:@"UserID"];
                        note.identifier = identfier?[NSString stringWithFormat:@"Note%@", identfier]:@"";
                        note.date = cdate?cdate:@"";
                        note.content = content?content:@"";
                        note.userID = userID?userID:@"";
                        [self.notes addObject:note];
                    }
                }
            }
            else if(code == -1){
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
    }
    if(!self.notesViewController){
        self.notesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    }
    self.notesViewController.notes = self.notes;
    [self.navigationController pushViewController:self.notesViewController animated:YES];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@", [request.error localizedDescription]);
}

- (IBAction)networkQueue:(id)sender {
    if(!self.imageViewController){
        self.imageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
    }

    [self.navigationController pushViewController:self.imageViewController animated:YES];
}

- (IBAction)uploadData:(id)sender {
    if(!self.uploadViewController){
        self.uploadViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UploadViewController"];
    }
    
    [self.navigationController pushViewController:self.uploadViewController animated:YES];
}



@end
