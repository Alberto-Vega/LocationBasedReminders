//
//  LocationController.h
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/24/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

@import UIKit;
@import CoreLocation;

@protocol LocationControllerDelegate <NSObject>

- (void)locationControllerDidUpdateLocation:(CLLocation *)location;

@end

@interface LocationController : NSObject

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) id delegate;

+ (LocationController *)sharedController;

@end

