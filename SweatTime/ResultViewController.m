//
//  ResultViewController.m
//  SweatTime
//
//  Created by Soul on 6/14/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultTableViewCell.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //tableview no row after the last data row and allow editing
    self.resultTable.allowsMultipleSelectionDuringEditing = NO;
    self.resultTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.resultTable.rowHeight = 80;
    
    self.emptyTable.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"commonFreeTime count is %lu", (unsigned long)[self.passedCommonFreeTime count]);
    
    if ([self.passedCommonFreeTime count] == 0) {
        self.emptyTable.hidden = NO;
    } else {
        self.emptyTable.hidden = YES;
    }
    
    return [self.passedCommonFreeTime count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *resultTableIdentifier = @"freeTimeResult";
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resultTableIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resultTableIdentifier];
    }
    
    FreeTime *tmpFree = [self.passedCommonFreeTime objectAtIndex:indexPath.row];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:tmpFree.startDate];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:tmpFree.endDate];
    NSInteger day2 = [components2 day];
    NSInteger month2 = [components2 month];
    NSInteger year2 = [components2 year];
    
    if(day == day2 && month == month2 && year == year2)
    {
        cell.dateLabel.text = [NSString stringWithFormat:@"%i - %i - %i",day,month,year];
    }
    else
    {
        cell.dateLabel.text = [NSString stringWithFormat:@"%i - %i - %i to %i - %i - %i",day,month,year, day2, month2, year2];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *startString = [formatter stringFromDate:tmpFree.startDate];
    NSString *endString = [formatter stringFromDate:tmpFree.endDate];
    
    
    cell.timeIntervalLabel.text = [NSString stringWithFormat:@"%@ - %@", startString, endString];
    // Configure the cell...
    
    return cell;
}

- (IBAction)backButton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
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
