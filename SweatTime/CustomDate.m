//
//  CustomDate.m
//  SweatTime
//
//  Created by Soul on 6/14/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "CustomDate.h"

@implementation NSDate (CustomDate)
- (BOOL)isBetweenDate:(NSDate *)earlierDate andDate:(NSDate *)laterDate
{
    // first check that we are later than the earlierDate.
    if ([self compare:earlierDate] == NSOrderedDescending) {
        
        // next check that we are earlier than the laterData
        if ( [self compare:laterDate] == NSOrderedAscending ) {
            return YES;
        }
    }
    
    // otherwise we are not
    return NO;
}

- (BOOL)isEarlierThanDate:(NSDate *)comparedDate{
    if ([self compare:comparedDate] == NSOrderedDescending) {
        //NSLog(@"date1 is later than date2");
        return NO;
    } else if ([self compare:comparedDate] == NSOrderedAscending) {
        //NSLog(@"date1 is earlier than date2");
        return YES;
    } else {
        //NSLog(@"dates are the same");
        return NO;
    }
}

- (BOOL)isLaterThanDate:(NSDate *)comparedDate{
    if ([self compare:comparedDate] == NSOrderedDescending) {
        //NSLog(@"date1 is later than date2");
        return YES;
    } else if ([self compare:comparedDate] == NSOrderedAscending) {
        //NSLog(@"date1 is earlier than date2");
        return NO;
    } else {
        //NSLog(@"dates are the same");
        return NO;
    }
}

- (BOOL)isEqualWithDate:(NSDate *)comparedDate{
    if ([self compare:comparedDate] == NSOrderedDescending) {
        //NSLog(@"date1 is later than date2");
        return NO;
    } else if ([self compare:comparedDate] == NSOrderedAscending) {
        //NSLog(@"date1 is earlier than date2");
        return NO;
    } else {
        //NSLog(@"dates are the same");
        return YES;
    }
}
@end
