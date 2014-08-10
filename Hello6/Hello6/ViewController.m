//
//  ViewController.m
//  Hello6
//
//  Created by cavernyu on 13-11-9.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

#import "ViewController.h"
#import "LandscapeViewController.h"
#define deg2rad 3.1415926/180
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	LandscapeViewController *landscapeViewController = [[UIStoryboard storyboardWithName:@"LandscapeStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"LandscapeViewController"];
    self.mainLandscapeView =  landscapeViewController.view;
    self.mainPortraitView = self.view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.view = self.mainLandscapeView;
        self.view.transform = CGAffineTransformMakeRotation(deg2rad*90);
        self.view.bounds = CGRectMake(0.0, 0.0, 460.0, 320.0);
    }else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        self.view = self.mainLandscapeView;
        self.view.transform = CGAffineTransformMakeRotation(deg2rad*(-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 460.0, 320.0);
    }else{
        self.view = self.mainPortraitView;
        self.view.transform = CGAffineTransformMakeRotation(deg2rad*0);
        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
    }
    
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

@end
