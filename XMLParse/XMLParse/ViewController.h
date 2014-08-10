//
//  ViewController.h
//  XMLParse
//
//  Created by cavernyu on 14-5-29.
//  Copyright (c) 2014年 cavernyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesViewController.h"
#import "Note.h"
#import "TBXML.h"
#import "NSString+URLEncoding.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ImageViewController.h"
#import "UploadViewController.h"

@interface ViewController : UIViewController <NSXMLParserDelegate, NSURLConnectionDataDelegate, ASIHTTPRequestDelegate>
@property (nonatomic, strong) NotesViewController *notesViewController;
@property (nonatomic, strong) ImageViewController *imageViewController;
@property (nonatomic, strong) UploadViewController *uploadViewController;
@property (nonatomic, strong) NSString *currentElementName;
@property (nonatomic, strong) NSMutableArray *notes;
@property (nonatomic, strong) Note *note;
@property (nonatomic, strong) NSMutableData *data;

- (IBAction)xmlParseNSXML:(id)sender;
- (IBAction)xmlParse_TBXML:(id)sender;

- (IBAction)parseJSON:(id)sender;
- (IBAction)synchronousGet:(id)sender;
- (IBAction)asynchronousGet:(id)sender;
- (IBAction)asynchronousPost:(id)sender;
- (IBAction)synGetASIHTTPRequest:(id)sender;
- (IBAction)synPostASIHTTPRequest:(id)sender;
- (IBAction)asynGetASIHTTPRequest:(id)sender;
- (IBAction)networkQueue:(id)sender;
- (IBAction)uploadData:(id)sender;

@end
