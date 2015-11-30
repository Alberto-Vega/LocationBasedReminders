//
//  ViewController.m
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/23/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import "ViewController.h"
#import "LocationController.h"
#import "DetailViewController.h"
#import "Reminder.h"

@import Parse;
@import ParseUI;

@interface ViewController () <LocationControllerDelegate, MKMapViewDelegate, PFLogInViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;
-(IBAction)locationButtonSelected:(UIButton *)sender;

@property (strong, nonatomic) NSArray *remindersFromParse;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.locationMapView setDelegate:self];
    [self.locationMapView setShowsUserLocation: YES];
    [self.locationMapView.layer setCornerRadius:20.0];
    
    // Parse.
    [self login];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reminder"];
    
//    [query whereKeyExists:[[PFUser currentUser] objectId]];
//  [query whereKey:@"location" nearGeoPoint: self.locationMapView];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {

     if (!error) {
         NSLog(@"Successfully retrieved %lu reminders.", objects.count);
         self.remindersFromParse = [[NSArray alloc] initWithArray:objects];
         for( Reminder *reminder in self.remindersFromParse) {
             CLLocationCoordinate2D location = CLLocationCoordinate2DMake(reminder.location.latitude, reminder.location.longitude);
             if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                 // Create new region and start monitoring it.
                 
                 double dRadius = [reminder.radius doubleValue];

                 CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location radius:dRadius identifier:reminder.name];
                 [[[LocationController sharedController]locationManager] startMonitoringForRegion: region];
                 
                 __weak typeof(self) weakSelf = self;

                     [weakSelf.locationMapView addOverlay:[MKCircle circleWithCenterCoordinate: location radius: region.radius]];
                     
                     NSLog(@"%@", [[LocationController sharedController]locationManager]);
             }
         }
         
     } else {
         // Print details for the error if there is one.
         NSLog(@"Error: %@ %@", error, [error userInfo]);
     }
      }];
     }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Start location manager.
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailViewController"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotationView = (MKAnnotationView *)sender;
            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            detailViewController.annotationTitle = annotationView.annotation.title;
            detailViewController.coordinate = annotationView.annotation.coordinate;
            
            __weak typeof(self) weakSelf = self;
            
            detailViewController.completion = ^(MKCircle *circle) {
                
                [weakSelf.locationMapView removeAnnotation: annotationView.annotation];
                [weakSelf.locationMapView addOverlay:circle];
                
                NSLog(@"%@", [[LocationController sharedController]locationManager]);
            };
        }
    }
}

- (void)setRegionForCoordinate:(MKCoordinateRegion)region {
    [self.locationMapView setRegion:region animated:YES];
}

- (void)setMapForCoordinateWithLatitude: (double)lat  andLongitude:(double)longa {

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, longa);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 2000.0, 2000.0);
    [self setRegionForCoordinate:region];
}

- (IBAction)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchPoint = [gesture locationInView:self.locationMapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.locationMapView convertPoint:touchPoint toCoordinateFromView:self.locationMapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        newPoint.coordinate = touchMapCoordinate;
        newPoint.title = @"New Location";
        
        [self.locationMapView addAnnotation:newPoint];
    }
}

- (IBAction)locationButtonSelected:(UIButton *)sender {
    NSString *buttonTitle =  sender.titleLabel.text;
    
    [self setMapForCoordinateWithLatitude:0.32 andLongitude:122.333];
    
    if ([buttonTitle isEqualToString:@"San Carlos"]) {
        NSLog(@"San Carlos");
        [self setMapForCoordinateWithLatitude:27.961787 andLongitude:-111.037099];
    }
    
    if ([buttonTitle isEqualToString:@"La Manga"]) {
        NSLog(@"La Manga");
        [self setMapForCoordinateWithLatitude:27.980199 andLongitude:-111.123508];
    }
    
    if ([buttonTitle isEqualToString:@"Cañon del Nacapule"]) {
        NSLog(@"Cañon del Nacapule");
        [self setMapForCoordinateWithLatitude:28.015563 andLongitude:-111.049235];
    }
}

#pragma mark - LocationController

- (void)locationControllerDidUpdateLocation:(CLLocation *)location {
    [self setRegionForCoordinate:MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0)];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) { return nil; }
    
    // Add view.
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[_locationMapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
    annotationView.annotation = annotation;
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    }
    
    annotationView.canShowCallout = true;
    UIButton *rightCallout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCallout;

    return annotationView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    circleRenderer.strokeColor = [UIColor blueColor];
    circleRenderer.fillColor = [UIColor redColor];
    circleRenderer.alpha = 0.5;
    return circleRenderer;
}

#pragma mark - Parse

-(void)setupAdditionalUI {
    UIBarButtonItem *signoutButton = [[UIBarButtonItem alloc]initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signout)];
    self.navigationItem.leftBarButtonItem = signoutButton;
}

- (void)login {
    if (![PFUser currentUser]) {
        
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc]init];
        loginViewController.delegate = self;
        
        [self presentViewController:loginViewController animated:NO completion:nil];
    } else {
        [self setupAdditionalUI];
    }
}

- (void)signout {
    [PFUser logOut];
    [self login];
}
    // Delegate
    
    - (void)logInViewController: (PFLogInViewController *)logInController didLogInUser: (PFUser *)user {
        [self dismissViewControllerAnimated: YES completion:nil];
        [self setupAdditionalUI];
    }
       

@end
