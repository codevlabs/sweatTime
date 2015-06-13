//
//  CustomDate.h
//  SweatTime
//
//  Created by Soul on 6/14/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CustomDate)
-(BOOL)isBetweenDate:(NSDate *)earlierDate andDate:(NSDate *)laterDate;
-(BOOL)isLaterThanDate:(NSDate *)comparedDate;
-(BOOL)isEarlierThanDate:(NSDate *)comparedDate;
-(BOOL)isEqualWithDate:(NSDate *)comparedDate;
@end
