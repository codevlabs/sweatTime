//
//  CompareViewController.h
//  SweatTime
//
//  Created by Soul on 6/14/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeTime.h"
#import "CustomDate.h"
#import "ResultViewController.h"

@interface CompareViewController : UIViewController
    @property (nonatomic, strong) NSArray *arrCalendars;
    @property (nonatomic, strong) NSMutableArray *freeCalendars;
    @property (nonatomic, strong) NSMutableArray *freeTimePassedFromHost;
    @property (nonatomic, strong) NSMutableArray *commonFreeTime;
@end
