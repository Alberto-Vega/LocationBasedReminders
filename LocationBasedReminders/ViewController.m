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

@interface ViewController () <LocationControllerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.locationMapView setDelegate:self];
    [self.locationMapView setShowsUserLocation: YES];
    [self.locationMapView.layer setCornerRadius:20.0];
    
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

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
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

@end
