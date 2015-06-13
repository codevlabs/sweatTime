//
//  DatePickViewController.m
//  SweatTime
//
//  Created by Soul on 6/13/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "DatePickViewController.h"

@interface DatePickViewController ()

@end

@implementation DatePickViewController
NSUserDefaults *defaults;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set nsdefault
    defaults = [NSUserDefaults standardUserDefaults];
    
    //Initialize defaults
    [defaults setObject:[NSDate date] forKey:@"startDate"];
    [defaults setObject:[NSDate date] forKey:@"endDate"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d MMM yyyy";
    NSString *dstring = [formatter stringFromDate:[NSDate date]];
    
    self.chooseStartDateButton.tag = 42;
    self.chooseEndDateButton.tag = 43;
    
    //Initialize button to current date
    [self.chooseStartDateButton setTitle:dstring forState:UIControlStateNormal];
    [self.chooseEndDateButton setTitle:dstring forState:UIControlStateNormal];
    
    //set next button style
    self.nextButton.clipsToBounds = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startDateChanged:(id)sender {
    NSDate *chosenStartDate = self.startDatePicker.date;
    NSDate *chosenEndDate = self.endDatePicker.date;
    
    //start date later than end date
    if ([chosenStartDate compare:chosenEndDate] == NSOrderedDescending) {
        [self.endDatePicker setDate:chosenStartDate];
        self.endDatePicker.minimumDate = self.startDatePicker.date;
    }
}

- (IBAction)endDateChanged:(id)sender {
    NSDate *chosenStartDate = self.startDatePicker.date;
    NSDate *chosenEndDate = self.endDatePicker.date;
    
    //start date later than end date
    if ([chosenStartDate compare:chosenEndDate] == NSOrderedDescending) {
        [self.endDatePicker setDate:chosenStartDate];
        self.endDatePicker.minimumDate = self.startDatePicker.date;
    }
}

- (IBAction)chooseDatePressed:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, self.view.frame.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-216-44)];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    //datePicker.tag = 10;
    datePicker.tag = ((UIButton *)sender).tag + 10;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate = [NSDate date];
    
    if(datePicker.tag == 53)
    {
        datePicker.minimumDate = [defaults objectForKey:@"startDate"];
    }
    //datePicker.tag = ((UIButton *)sender).tag;
    
    darkView.alpha = 0.5;
    [self.nextButton setEnabled:NO];
    self.nextButton.alpha = 0.0;
    
    [UIView commitAnimations];
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    //[[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
    [[self.view viewWithTag:52] removeFromSuperview];
    [[self.view viewWithTag:53] removeFromSuperview];
    
    //start date later than end date
    if ([[defaults objectForKey:@"startDate"] compare:[defaults objectForKey:@"endDate"]] == NSOrderedDescending) {
        //set end date same as start date
        NSDate *startDate = [defaults objectForKey:@"startDate"];
        [defaults setObject:startDate forKey:@"endDate"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"d MMM yyyy";
        NSString *dstring = [formatter stringFromDate:startDate];
        [self.chooseEndDateButton setTitle:dstring forState:UIControlStateNormal];
    }
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    
    [self.nextButton setEnabled:YES];
    self.nextButton.alpha = 1.0;
    [UIView commitAnimations];
    
}

- (void)changeDate:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSLog(@"picker tag: %i", sender.tag);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d MMM yyyy";
    NSString *senderDatestring = [formatter stringFromDate:sender.date];
    
    if(sender.tag == 52)
    {
        [self.chooseStartDateButton setTitle:senderDatestring forState:UIControlStateNormal];
        [defaults setObject:sender.date forKey:@"startDate"];
    }
    
    if(sender.tag == 53)
    {
        [self.chooseEndDateButton setTitle:senderDatestring forState:UIControlStateNormal];
        [defaults setObject:sender.date forKey:@"endDate"];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"preparing");
}

@end
