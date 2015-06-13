//
//  AppDelegate.h
//  SweatTime
//
//  Created by Soul on 6/13/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) EventManager *eventManager;

@end

