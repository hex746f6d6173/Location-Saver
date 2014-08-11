//
//  LSBookmarkController.m
//  Location Saver
//
//  Created by Tomas Harkema on 11/08/14.
//  Copyright (c) 2014 Tomas Harkema. All rights reserved.
//

#import "LSBookmarkController.h"

#import "LSStorage.h"
#import "LSLocation.h"
#import "LSLocationDetail.h"

@interface LSBookmarkController ()

@property (strong, nonatomic) NSArray *locations;

@end

@implementation LSBookmarkController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  //_locations = [LSStorage getLocations];
}

- (void)viewWillAppear:(BOOL)animated
{
  _locations = [LSStorage getLocations];
  NSLog(@"LOCATIONS: %@", _locations);
  [self.tableView reloadData];
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [_locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  cell.textLabel.text = [_locations objectAtIndex:indexPath.row][@"title"];
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  LSLocationDetail *dvc = [segue destinationViewController];
  
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  
  dvc.title = [_locations objectAtIndex:indexPath.row][@"title"];
  dvc.location = CLLocationCoordinate2DMake([(NSNumber *)[_locations objectAtIndex:indexPath.row][@"lat"] doubleValue], [(NSNumber *)[_locations objectAtIndex:indexPath.row][@"lon"] doubleValue]);
}

@end
