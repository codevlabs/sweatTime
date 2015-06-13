//
//  DatePickViewController.h
//  SweatTime
//
//  Created by Soul on 6/13/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *chooseStartDateButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseEndDateButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
