//
//  MainViewController.m
//  SweatTime
//
//  Created by Soul on 6/13/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController
AppDelegate *appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    //set hostbutton layout
    self.hostButton.layer.cornerRadius = 20;
    self.hostButton.clipsToBounds = YES;
    //set clientbutton layout
    self.clientButton.layer.cornerRadius = 20;
    self.clientButton.clipsToBounds = YES;
    
    [self performSelector:@selector(requestAccessToEvents) withObject:nil afterDelay:0.4];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
    
    //hide data transferred label
    self.dataTransferredLabel.hidden = YES;
    self.dataTransferredLabel.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated{
    if(self.dataTransferredLabel.hidden == NO)
    {
        [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{self.dataTransferredLabel.alpha = 0.0;} completion: ^(BOOL finished){
            self.dataTransferredLabel.hidden = YES;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestAccessToEvents{
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.eventManager.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (error == nil) {
            // Store the returned granted value.
            appDelegate.eventManager.eventsAccessGranted = granted;
        }
        else{
            // In case of error, just log its description to the debugger.
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
