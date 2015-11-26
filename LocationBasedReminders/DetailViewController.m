//
//  DetailViewController.m
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/24/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"
#import "LocationController.h"

@import Parse;
@import MapKit;

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;
- (IBAction)createReminderButtonSelected:(UIButton *)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.annotationTitle);
    NSLog(@"%f %f", self.coordinate.latitude, self.coordinate.longitude);    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.nameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createReminderButtonSelected:(UIButton *)sender {
    
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = self.nameTextField.text;
    reminder.radius = [NSNumber numberWithFloat:self.radiusTextField.text.floatValue];
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [reminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Reminder saved to Parse");
        
        // If completion was set.
        
        if (self.completion) {
            // Check for abilities then...
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                // Create new region and...
                CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:self.radiusTextField.text.floatValue identifier:self.nameTextField.text];
                [[[LocationController sharedController]locationManager]startMonitoringForRegion:region];
                
                // Pass it back to be added to the map.
                self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:self.radiusTextField.text.floatValue]);
                
                // Dismiss.
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
