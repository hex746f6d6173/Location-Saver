//
//  LSStorage.m
//  Location Saver
//
//  Created by Tomas Harkema on 11/08/14.
//  Copyright (c) 2014 Tomas Harkema. All rights reserved.
//

#import "LSStorage.h"
#import "LSLocation.h"

@implementation LSStorage

+ (void)saveLocation:(LSLocation *)location
{
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  NSMutableArray *set = [(NSArray *)[defaults objectForKey:@"locations"] mutableCopy];
  
  if (!set)
    set = [NSMutableArray new];
  
  NSDictionary *dict = @{@"title":location.title,
                    @"lat":@(location.coordinate.latitude),
                    @"lon":@(location.coordinate.longitude)};
  
  [set addObject:dict];
  
  [defaults setObject:set forKey:@"locations"];
  [defaults synchronize];
}

+ (NSArray *)getLocations
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"locations"];
}

@end
