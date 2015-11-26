//
//  Reminder.h
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/25/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

@import Parse;
@import Foundation;

@interface Reminder : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSNumber *radius;

@end
