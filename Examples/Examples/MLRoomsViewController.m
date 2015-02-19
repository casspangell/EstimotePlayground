//
//  MLRoomsViewController.m
//  Examples
//
//  Created by Cass Pangell on 7/28/14.
//  Copyright (c) 2014 com.estimote. All rights reserved.
//

#import "MLRoomsViewController.h"
#import "ESTBeaconManager.h"

@interface MLRoomsViewController () <ESTBeaconManagerDelegate>{
    
}

@property (nonatomic, strong) ESTBeacon         *beacon;
@property (nonatomic, strong) ESTBeaconManager  *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion   *beaconRegion;

@end

@implementation MLRoomsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithBeacon:(ESTBeacon *)beacon
{
    self = [super init];
    if (self)
    {
        self.beacon = beacon;
        self.beacon.delegate = self;
        [self.beacon connect];
        NSLog(@"BEACON %@", beacon.name);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _beaconsArray = [[NSArray alloc] init];
    
    self.beaconTable.delegate = self;
    self.beaconTable.dataSource = self;

    /*
     * BeaconManager setup.
     */
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID
                                                                 major:[self.beacon.major unsignedIntValue]
                                                                 minor:[self.beacon.minor unsignedIntValue]
                                                            identifier:@"RegionIdentifier"];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void) fade{
    [UIView animateWithDuration:1 animations:^(void) {
        [_selectLabel setAlpha:.3];
        [_beaconTable setAlpha:.3];
    }];
}

- (NSString *)textForProximity:(CLProximity)proximity
{

    switch (proximity) {
        case CLProximityFar:

            NSLog(@"Far");
            return @"Far";
            break;
        case CLProximityNear:

            NSLog(@"Near");
            return @"Near";
            break;
        case CLProximityImmediate:

            NSLog(@"Immediate");
            return @"Immediate";
            break;
            
        default:

            NSLog(@"unknown");
            return @"Unknown";
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"count %d",[_beaconsArray count]);
    return [_beaconsArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIdentifier"];

    }

 
    /*
     * Fill the table with beacon data.
     */
    ESTBeacon *beacon = [_beaconsArray objectAtIndex:indexPath.row];

        cell.textLabel.text = [NSString stringWithFormat:@"Major: %@, Minor: %@", beacon.major, beacon.minor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Distance: %.2f", [beacon.distance floatValue]];

    cell.imageView.image = [UIImage imageNamed:@"beacon"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESTBeacon *selectedBeacon = [_beaconsArray objectAtIndex:indexPath.row];
    NSLog(@"%@", selectedBeacon);
    [self fade];
    
    // self.completion(selectedBeacon);
}

#pragma mark - ESTBeaconManager delegate
//Detects all beacons in range
- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    if (beacons.count > 0)
    {
        _beaconsArray = beacons;
        NSLog(@"array: %@", _beaconsArray);
        [_beaconTable reloadData];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
