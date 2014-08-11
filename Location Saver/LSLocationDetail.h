//
//  LSLocationDetail.h
//  Location Saver
//
//  Created by Tomas Harkema on 11/08/14.
//  Copyright (c) 2014 Tomas Harkema. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreLocation;
@import MapKit;

@interface LSLocationDetail : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) NSString *locationTitle;
@property (assign, nonatomic) CLLocationCoordinate2D location;

@property (assign, nonatomic) NSUInteger index;

@end
