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
  
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMap:)];
  [_mapView addGestureRecognizer:tapGesture];
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

-(void)tapOnMap:(UIGestureRecognizer*)sender
{
  NSLog(@"TAP ON MAP: %@", sender);
  
  CGPoint point = [sender locationInView:_mapView];
  CLLocationCoordinate2D locCoord = [_mapView convertPoint:point toCoordinateFromView:_mapView];
  
  NSLog(@"TAP ON MAP: %f", locCoord.latitude);
  
  LSLocation *pin = [LSLocation new];
  pin.coordinate = locCoord;
  
  [_mapView addAnnotation:pin];
  
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
  
}

@end
