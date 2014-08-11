//
//  LSLocationDetail.m
//  Location Saver
//
//  Created by Tomas Harkema on 11/08/14.
//  Copyright (c) 2014 Tomas Harkema. All rights reserved.
//

#import "LSLocationDetail.h"

#import "LSLocation.h"
#import "LSStorage.h"

@import CoreLocation;
@import MapKit;

@interface LSLocationDetail ()

@property (weak, nonatomic) IBOutlet MKMapView *detailMap;
@property (weak, nonatomic) IBOutlet UILabel *lat;
@property (weak, nonatomic) IBOutlet UILabel *lon;

@end

@implementation LSLocationDetail

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
  _detailMap.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
  MKCoordinateRegion region;
  region.center = _location;
  region.span.latitudeDelta = 0.01;
  region.span.longitudeDelta = 0.01;
  
  [_detailMap setRegion:region animated:NO];
  
  LSLocation *loc = [LSLocation new];
  loc.coordinate = _location;
  
  [_detailMap addAnnotation:loc];
  
  _lat.text = [NSString stringWithFormat:@"%f", _location.latitude];
  _lon.text = [NSString stringWithFormat:@"%f", _location.longitude];
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)remove:(id)sender
{
  [LSStorage removeLocationAtIndex:_index];
  
  [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
