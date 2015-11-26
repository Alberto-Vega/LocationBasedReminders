//
//  Reminder.m
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/25/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic name;
@dynamic location;
@dynamic radius;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Reminder";
}

@end
