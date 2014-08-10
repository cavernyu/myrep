//
//  ViewController.m
//  ModelViewSample
//
//  Created by cavernyu on 13-12-25.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#import "ModelViewController.h"

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

- (IBAction)showModelView:(id)sender {
    ModelViewController *modelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"modelViewController"];
    
    modelViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    switch (self.segmentedController.selectedSegmentIndex){
        case 0:
            modelViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            break;
        case 1:
            modelViewController.modalPresentationStyle = UIModalPresentationPageSheet;
            break;
        case 2:
            modelViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            break;
        default:
            modelViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
            break;
            
    }
    [self presentViewController:modelViewController animated:YES completion:nil];
}
@end
