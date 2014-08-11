//
//  LSLocation.h
//  Location Saver
//
//  Created by Tomas Harkema on 11/08/14.
//  Copyright (c) 2014 Tomas Harkema. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;
@import CoreLocation;

@interface LSLocation : NSObject <MKAnnotation> {
  NSString *_title;
  NSString *_subtitle;
  
  CLLocationCoordinate2D _coordinate;
}

- (void)setTitle:(NSString *)title;

@end
