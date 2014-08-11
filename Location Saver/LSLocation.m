//
//  LSLocation.m
//  Location Saver
//
//  Created by Tomas Harkema on 11/08/14.
//  Copyright (c) 2014 Tomas Harkema. All rights reserved.
//

#import "LSLocation.h"

@import MapKit;
@import CoreLocation;

@interface LSLocation () <MKAnnotation>

@end

@implementation LSLocation

- (NSString *)title {
  return _title;
}

- (NSString *)subtitle {
  return _subtitle;
}

- (void)setTitle:(NSString *)title {
  if (_title != title) {
    _title = title;
  }
}

- (void)setSubtitle:(NSString *)subtitle {
  if (_subtitle != subtitle) {
    _subtitle = subtitle;
  }
}

- (CLLocationCoordinate2D)coordinate {
  return _coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
  _coordinate = newCoordinate;
}

@end
