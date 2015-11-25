//
//  DetailViewController.h
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/24/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *annotationTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
