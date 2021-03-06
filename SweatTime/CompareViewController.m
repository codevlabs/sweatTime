//
//  CompareViewController.m
//  SweatTime
//
//  Created by Soul on 6/14/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "CompareViewController.h"
#import "FreeTime.h"
#import <EventKitUI/EventKitUI.h>
@interface CompareViewController ()

@end

@implementation CompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"other free time count %lu", (unsigned long)[self.freeTimePassedFromHost count]);
    self.commonFreeTime = [[NSMutableArray alloc] init];
    self.freeCalendars = [[NSMutableArray alloc] init];
    [self loadEventCalendars];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadEventCalendars{
    
    EKEventStore *store = [[EKEventStore alloc] init];
    
    // Load all local event calendars.
    // Get the appropriate calendar
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    
    // Create the start date components
    NSDateComponents *start_date_components = [[NSDateComponents alloc] init];
    start_date_components.day = [self daysBetweenDate:[NSDate date] andDate: ((FreeTime *)[self.freeTimePassedFromHost objectAtIndex:0]).startDate];;
    NSDate *start_date = [calendar dateByAddingComponents:start_date_components
                                                   toDate:[NSDate date]
                                                  options:0];
    //start_date = [calendar dateBySettingHour:0  minute:0  second:0  ofDate:start_date options:0];
    start_date =((FreeTime *)[self.freeTimePassedFromHost objectAtIndex:0]).startDate;
    
    
    // Create the end date components
    NSDateComponents *end_date_components = [[NSDateComponents alloc] init];
    end_date_components.day = [self daysBetweenDate:[NSDate date] andDate:((FreeTime *)[self.freeTimePassedFromHost lastObject]).endDate];
    NSDate *end_date_end = [calendar dateBySettingHour:23 minute:59 second:59 ofDate:now options:0];
    NSDate *end_date = [calendar dateByAddingComponents:end_date_components
                                                 toDate:end_date_end
                                                options:0];
    end_date = ((FreeTime *)[self.freeTimePassedFromHost lastObject]).endDate;
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:start_date
                                                            endDate:end_date
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    self.arrCalendars = [store eventsMatchingPredicate:predicate];
    
    [self availableslot];
    // Reload the table view.
    //[self.tblCalendars reloadData];
}

-(void)availableslot{
    int x = 0;
    NSDate *startdate;
    NSDate *enddate;
    EKEventStore *store = [[EKEventStore alloc] init];
    EKEvent *freetime = [EKEvent eventWithEventStore:store];
    
    
    for(x = 0 ; x < self.arrCalendars.count ; x++){
        EKEvent *currentEvent = [self.arrCalendars objectAtIndex:x];
        NSDate *currentDate = currentEvent.startDate;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:currentDate];
        NSInteger year = [components year];
        NSInteger month = [components month];
        NSInteger day = [components day];
        NSInteger hour = [components hour];
        NSInteger minute = [components minute];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        FreeTime *free = [[FreeTime alloc] init];
        
        
        if(x == 0 ){
            
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSTimeZone *pacificTime = [NSTimeZone timeZoneWithName:@"Asia/Kuala_Lumpur"];
            
            NSDateComponents *startdatecomp = [[NSDateComponents alloc] init];
            [startdatecomp setCalendar:gregorian];
            [startdatecomp setYear:year];
            [startdatecomp setMonth:month];
            [startdatecomp setDay:day];
            [startdatecomp setHour:0];
            [startdatecomp setMinute:0];
            [startdatecomp setTimeZone:pacificTime];
            
            startdate = [startdatecomp date];
            
            
            
            NSDateComponents *enddatecomp = [[NSDateComponents alloc] init];
            [enddatecomp setCalendar:gregorian];
            [enddatecomp setYear:year];
            [enddatecomp setMonth:month];
            [enddatecomp setDay:day];
            [enddatecomp setHour:hour];
            [enddatecomp setMinute:minute];
            [enddatecomp setTimeZone:pacificTime];
            
            enddate = [enddatecomp date];
            NSLog(@" Before Woohoo compareview %@",startdate);
            NSLog(@" Before Woohoo compareview %@",enddate);
            
            freetime.startDate = startdate;
            freetime.endDate = enddate;
            
            //[array addObject:[startdate copy]];
            //[array addObject:[enddate copy]];
            
            free.startDate = [startdate copy];
            free.endDate = [enddate copy];
            
            [self.freeCalendars addObject:free];
            
            //array = [[NSMutableArray alloc] init];
            free = [[FreeTime alloc] init];
            
            //get second data
            EKEvent *nextEvent1 = [self.arrCalendars objectAtIndex:x];
            NSDate *nextDate1 = nextEvent1.endDate;
            NSCalendar *nextCal1 = [NSCalendar currentCalendar];
            NSDateComponents *nextcomponents1 = [nextCal1 components:(NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:nextDate1];
            NSInteger nextyear1 = [nextcomponents1 year];
            NSInteger nextmonth1 = [nextcomponents1 month];
            NSInteger nextday1 = [nextcomponents1 day];
            NSInteger nexthour1 = [nextcomponents1 hour];
            NSInteger nextminute1 = [nextcomponents1 minute];
            
            
            
            
            EKEvent *secondnextEvent = [self.arrCalendars objectAtIndex:x+1];
            NSDate *secondnextDate = secondnextEvent.startDate;
            NSCalendar *secondnextCal = [NSCalendar currentCalendar];
            NSDateComponents *secondcomponents = [secondnextCal components:(NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:secondnextDate];
            NSInteger secondnextyear = [secondcomponents year];
            NSInteger secondnextmonth = [secondcomponents month];
            NSInteger secondnextday = [secondcomponents day];
            NSInteger secondnexthour = [secondcomponents hour];
            NSInteger secondnextminute = [secondcomponents minute];
            
            
            
            NSCalendar *secondgregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSTimeZone *secondpacificTime = [NSTimeZone timeZoneWithName:@"Asia/Kuala_Lumpur"];
            
            NSDateComponents *nextdatecomp = [[NSDateComponents alloc] init];
            [nextdatecomp setCalendar:gregorian];
            [nextdatecomp setYear:nextyear1];
            [nextdatecomp setMonth:nextmonth1];
            [nextdatecomp setDay:nextday1];
            [nextdatecomp setHour:nexthour1];
            [nextdatecomp setMinute:nextminute1];
            [nextdatecomp setTimeZone:pacificTime];
            
            startdate = [nextdatecomp date];
            
            
            
            NSDateComponents *secondenddatecomp = [[NSDateComponents alloc] init];
            [secondenddatecomp setCalendar:gregorian];
            [secondenddatecomp setYear:secondnextyear];
            [secondenddatecomp setMonth:secondnextmonth];
            [secondenddatecomp setDay:secondnextday];
            [secondenddatecomp setHour:secondnexthour];
            [secondenddatecomp setMinute:secondnextminute];
            [secondenddatecomp setTimeZone:pacificTime];
            
            enddate = [secondenddatecomp date];
            NSLog(@"Woohoo start : %@",startdate);
            NSLog(@"Woohoo end : %@",enddate);
            
            //[array addObject:[startdate copy]];
            //[array addObject:[enddate copy]];
            
            
            free.startDate = [startdate copy];
            free.endDate = [enddate copy];
            
            if([self.freeCalendars count] < 1)
            {
                self.freeCalendars = [NSMutableArray arrayWithObject:free];
            }
            else
            {
                [self.freeCalendars addObject:free];
            }
            
            
            
            
        }
        
        else if(x+1 == self.arrCalendars.count)
        {
            
            EKEvent *endEvent = [self.arrCalendars objectAtIndex:x];
            NSDate *endDate = endEvent.endDate;
            NSCalendar *endCalendar = [NSCalendar currentCalendar];
            NSDateComponents *endcomp = [endCalendar components:(NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:endDate];
            NSInteger endyear = [endcomp year];
            NSInteger endmonth = [endcomp month];
            NSInteger endday = [endcomp day];
            NSInteger endhour = [endcomp hour];
            NSInteger endminute = [endcomp minute];
            
            
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSTimeZone *pacificTime = [NSTimeZone timeZoneWithName:@"Asia/Kuala_Lumpur"];
            
            NSDateComponents *startdatecomp1 = [[NSDateComponents alloc] init];
            [startdatecomp1 setCalendar:gregorian];
            [startdatecomp1 setYear:endyear];
            [startdatecomp1 setMonth:endmonth];
            [startdatecomp1 setDay:endday];
            [startdatecomp1 setHour:endhour];
            [startdatecomp1 setMinute:endminute];
            [startdatecomp1 setTimeZone:pacificTime];
            
            startdate = [startdatecomp1 date];
            
            
            
            NSDateComponents *enddatecomp1 = [[NSDateComponents alloc] init];
            [enddatecomp1 setCalendar:gregorian];
            [enddatecomp1 setYear:year];
            [enddatecomp1 setMonth:month];
            [enddatecomp1 setDay:day];
            [enddatecomp1 setHour:23];
            [enddatecomp1 setMinute:59];
            [enddatecomp1 setTimeZone:pacificTime];
            
            enddate = [enddatecomp1 date];
            NSLog(@"%@",startdate);
            NSLog(@"%@",enddate);
            
            //[array addObject:[startdate copy]];
            //[array addObject:[enddate copy]];
            
            free.startDate = [startdate copy];
            free.endDate = [enddate copy];
            if([self.freeCalendars count] < 1)
            {
                self.freeCalendars = [NSMutableArray arrayWithObject:free];
            }
            else
            {
                [self.freeCalendars addObject:free];
            }
            
        }
        else{
            
            EKEvent *endEvent = [self.arrCalendars objectAtIndex:x];
            NSDate *endDate = endEvent.endDate;
            NSCalendar *endCal = [NSCalendar currentCalendar];
            NSDateComponents *endcomp = [endCal components:(NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:endDate];
            NSInteger nextyear = [endcomp year];
            NSInteger nextmonth = [endcomp month];
            NSInteger nextday = [endcomp day];
            NSInteger nexthour = [endcomp hour];
            NSInteger nextminute = [endcomp minute];
            
            
            EKEvent *nextEvent = [self.arrCalendars objectAtIndex:x+1];
            NSDate *nextDate = nextEvent.startDate;
            NSCalendar *nextCal = [NSCalendar currentCalendar];
            NSDateComponents *endcomponents = [nextCal components:(NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:nextDate];
            NSInteger endnextyear = [endcomponents year];
            NSInteger endnextmonth = [endcomponents month];
            NSInteger endnextday = [endcomponents day];
            NSInteger endnexthour = [endcomponents hour];
            NSInteger endnextminute = [endcomponents minute];
            
            
            
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSTimeZone *pacificTime = [NSTimeZone timeZoneWithName:@"Asia/Kuala_Lumpur"];
            
            NSDateComponents *startdatecomp2 = [[NSDateComponents alloc] init];
            [startdatecomp2 setCalendar:gregorian];
            [startdatecomp2 setYear:nextyear];
            [startdatecomp2 setMonth:nextmonth];
            [startdatecomp2 setDay:nextday];
            [startdatecomp2 setHour:nexthour];
            [startdatecomp2 setMinute:nextminute];
            [startdatecomp2 setTimeZone:pacificTime];
            
            startdate = [startdatecomp2 date];
            
            
            
            NSDateComponents *enddatecomp2 = [[NSDateComponents alloc] init];
            [enddatecomp2 setCalendar:gregorian];
            [enddatecomp2 setYear:endnextyear];
            [enddatecomp2 setMonth:endnextmonth];
            [enddatecomp2 setDay:endnextday];
            [enddatecomp2 setHour: endnexthour];
            [enddatecomp2 setMinute:endnextminute];
            [enddatecomp2 setTimeZone:pacificTime];
            
            enddate = [enddatecomp2 date];
            //NSLog(@"start : %@",startdate);
            //NSLog(@"end : %@",enddate);
            
            //[array addObject:[startdate copy]];
            //[array addObject:[enddate copy]];
            
            free.startDate = [startdate copy];
            free.endDate = [enddate copy];
            
            if([self.freeCalendars count] < 1)
            {
                self.freeCalendars = [NSMutableArray arrayWithObject:free];
            }
            else
            {
                [self.freeCalendars addObject:free];
            }
            
        }
        
        
        
    }
    
     NSLog(@"%lu", (unsigned long)[self.freeCalendars count]);
     
     for(FreeTime *fr in self.freeCalendars)
     {
     NSLog(@"my free start of : %@", fr.startDate);
     NSLog(@"my free end of : %@", fr.endDate);
     
     }
    [self findCommonFreeTime];
}

- (void)findCommonFreeTime{
    //self.freeCalendars = my free time
    //self.freeTimePassedFromHost = other free time
    NSDate *tmpHisFirstDate = ((FreeTime *)[self.freeTimePassedFromHost objectAtIndex:0]).startDate;
    NSDate *tmpHisLastDate  = ((FreeTime *)[self.freeTimePassedFromHost lastObject]).endDate;
    for(int a = 0; a < [self.freeTimePassedFromHost count]; a++)
    {
        NSDate *tmpHisStartDate = ((FreeTime *)[self.freeTimePassedFromHost objectAtIndex:a]).startDate;
        NSDate *tmpHisEndDate = ((FreeTime *)[self.freeTimePassedFromHost objectAtIndex:a]).endDate;
        for(int b = 0; b < [self.freeCalendars count]; b++)
        {
            NSDate *tmpMyStartDate = ((FreeTime *)[self.freeCalendars objectAtIndex:b]).startDate;
            NSDate *tmpMyEndDate = ((FreeTime *)[self.freeCalendars objectAtIndex:b]).endDate;
            FreeTime *tmpCommonFree  = [[FreeTime alloc]init];
            
            //NSLog(@"My current start %@", tmpMyStartDate);
            //NSLog(@"My current end %@", tmpMyEndDate);
            //NSLog(@"His current start %@", tmpHisStartDate);
            //NSLog(@"His current end %@", tmpHisEndDate);
            //skip faulty date, end time is earlier than start time, I have no idea why this is happening
            
            if([tmpMyEndDate isEarlierThanDate:tmpMyStartDate])
            {
                
                NSLog(@"continued tmpMyStart %@" ,tmpMyStartDate);
                NSLog(@"continued tmpMyEnd %@", tmpMyEndDate);
                continue;
            }
            
            //thank yooooouuuuu munyeeeee
            if([tmpMyStartDate isBetweenDate:tmpHisFirstDate andDate:tmpHisLastDate] && [tmpMyEndDate isBetweenDate:tmpHisFirstDate andDate:tmpHisLastDate] && [tmpHisEndDate isBetweenDate:tmpMyStartDate andDate:tmpMyEndDate])
            {
                //first case
                if([tmpHisStartDate isEarlierThanDate:tmpMyStartDate])
                {
                    tmpCommonFree.startDate = tmpMyStartDate;
                    NSLog(@"description  %@",tmpHisEndDate.description);
                    if([tmpHisEndDate isEqualToDate:tmpMyEndDate])
                    {
                        tmpCommonFree.endDate = [tmpHisEndDate copy];
                    }
                    else if([tmpHisEndDate isLaterThanDate:tmpMyEndDate])
                    {
                        tmpCommonFree.endDate = [tmpMyEndDate copy];
                    }
                    else
                    {
                        tmpCommonFree.endDate = [tmpHisEndDate copy];
                    }
                    
                    [self.commonFreeTime addObject:tmpCommonFree];
                }
                else if([tmpHisStartDate isLaterThanDate:tmpMyStartDate])
                {
                    tmpCommonFree.startDate = tmpHisStartDate;
                    if([tmpHisEndDate isEqualToDate:tmpMyEndDate])
                    {
                        tmpCommonFree.endDate = [tmpHisEndDate copy];
                    }
                    else if([tmpHisEndDate isLaterThanDate:tmpMyEndDate])
                    {
                        tmpCommonFree.endDate = [tmpMyEndDate copy];
                    }
                    else
                    {
                        tmpCommonFree.endDate = [tmpHisEndDate copy];
                    }
                    
                    [self.commonFreeTime addObject:tmpCommonFree];
                }
                else
                {
                    tmpCommonFree.startDate = tmpHisStartDate;
                    if([tmpHisEndDate isEqualToDate:tmpMyEndDate])
                    {
                        tmpCommonFree.endDate = [tmpHisEndDate copy];
                    }
                    else if([tmpHisEndDate isLaterThanDate:tmpMyEndDate])
                    {
                        tmpCommonFree.endDate = [tmpMyEndDate copy];
                    }
                    else
                    {
                        tmpCommonFree.endDate = [tmpHisEndDate copy];
                    }
                    
                    [self.commonFreeTime addObject:tmpCommonFree];
                }
                
            }
        }
    }
    
    NSLog(@"Common start %@", self.commonFreeTime);
    for(FreeTime *fr in self.commonFreeTime)
    {
        NSLog(@"common start %@", fr.startDate);
        NSLog(@"common end %@", fr.endDate);
    }
    
    [self performSegueWithIdentifier:@"showResult" sender:self];
}


//http://stackoverflow.com/questions/4739483/number-of-days-between-two-nsdates
//Day between nsdate
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}


- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showResult"])
    {
        ResultViewController *rvc = [segue destinationViewController];
        [rvc setPassedCommonFreeTime:self.commonFreeTime];
    }
}


@end
