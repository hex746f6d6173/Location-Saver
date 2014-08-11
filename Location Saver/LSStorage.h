//
//  LSStorage.h
//  Location Saver
//
//  Created by Tomas Harkema on 11/08/14.
//  Copyright (c) 2014 Tomas Harkema. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSLocation;

@interface LSStorage : NSObject

+ (void)saveLocation:(LSLocation *)location;
+ (NSArray *)getLocations;

@end
