//
//  ReminderTableViewController.h
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/29/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WatchKit;

@interface ReminderTableRowController : NSObject
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *ReminderDescriptionLabel;

@end
