//
//  LSMapViewController.m
//  Location Saver
//
//  Created by Tomas Harkema on 11/08/14.
//  Copyright (c) 2014 Tomas Harkema. All rights reserved.
//

#import "LSMapViewController.h"

#import "LSLocation.h"
#import "LSStorage.h"

@import CoreLocation;
@import MapKit;

@interface LSMapViewController () <MKMapViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (assign, nonatomic) CLLocationCoordinate2D currentLocation;

@property (strong, nonatomic) NSArray *locations;

@end

@implementation LSMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
    
  _mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [_mapView removeAnnotations:[_mapView annotations]];
  _locations = [LSStorage getLocations];
  
   [_locations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
     NSDictionary *dict = (NSDictionary *)obj;
     
     LSLocation *pin = [LSLocation new];
     pin.title = dict[@"title"];
     pin.coordinate = CLLocationCoordinate2DMake([(NSNumber *)dict[@"lat"] doubleValue], [(NSNumber *)dict[@"lon"] doubleValue]);
     
     [_mapView addAnnotation:pin];
     
   }];
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
  MKCoordinateRegion region;
  region.center = userLocation.coordinate;
  _currentLocation = userLocation.coordinate;
  region.span.latitudeDelta = 0.01;
  region.span.longitudeDelta = 0.01;
  
  [mapView setRegion:region animated:YES];
}

- (IBAction)tapOnMap:(id)sender
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add bookmark" message:@"Save the current location!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
  alert.alertViewStyle = UIAlertViewStylePlainTextInput;
  [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (buttonIndex != alertView.cancelButtonIndex) {
    LSLocation *savedLoc = [LSLocation new];
    [savedLoc setTitle:[alertView textFieldAtIndex:0].text];
    savedLoc.coordinate = _currentLocation;
    
    [LSStorage saveLocation:savedLoc];
    
    self.tabBarController.selectedIndex = 1;
  }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
  if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
    [self tapOnMap:nil];
  }
}

@end
