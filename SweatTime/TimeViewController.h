//
//  ViewController.h
//  SweatTime
//
//  Created by Soul on 6/13/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FreeTime.h"
@interface TimeViewController : UIViewController

@property (nonatomic, strong) NSArray *arrCalendars;
@property (nonatomic, strong) NSMutableArray *freeCalendars;


-(void)loadEventCalendars;


@end

