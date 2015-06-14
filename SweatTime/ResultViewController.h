//
//  ResultViewController.h
//  SweatTime
//
//  Created by Soul on 6/14/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeTime.h"

@interface ResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
    @property (nonatomic, strong) NSMutableArray *passedCommonFreeTime;
@property (weak, nonatomic) IBOutlet UITableView *resultTable;

@property (weak, nonatomic) IBOutlet UILabel *emptyTable;

@end
