//
//  ViewController.h
//  SweatTime
//
//  Created by Soul on 6/13/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <CoreBluetooth/CoreBluetooth.h>
#import "TransferService.h"

#import "FreeTime.h"
@interface TimeViewController : UIViewController <CBPeripheralManagerDelegate, UITextViewDelegate>


@property (strong, nonatomic) CBPeripheralManager       *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic   *transferCharacteristic;
@property (strong, nonatomic) NSData                    *dataToSend;
@property (nonatomic, readwrite) NSInteger              sendDataIndex;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISwitch *advertisingSwitch;

@property (nonatomic, strong) NSArray *arrCalendars;
@property (nonatomic, strong) NSMutableArray *freeCalendars;

@property (strong, nonatomic) NSMutableArray *receivedFreeTime;

-(void)loadEventCalendars;


@end

