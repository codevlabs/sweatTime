//
//  EventManager.h
//  SweatTime
//
//  Created by Munyee on 6/13/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface EventManager : NSObject
@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic) BOOL eventsAccessGranted;
-(NSArray *)getLocalEventCalendars;

@end
