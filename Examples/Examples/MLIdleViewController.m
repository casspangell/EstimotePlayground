//
//  MLIdleViewController.m
//  Examples
//
//  Created by Cass Pangell on 7/22/14.
//  Copyright (c) 2014 com.estimote. All rights reserved.
//

#import "MLIdleViewController.h"
#import "ESTBeaconManager.h"

#define MAX_DISTANCE 20
#define TOP_MARGIN   150

@interface MLIdleViewController () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeacon         *beacon;
@property (nonatomic, strong) ESTBeaconManager  *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion   *beaconRegion;

@end

@implementation MLIdleViewController

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
        NSLog(@"BEACON %@", beacon.macAddress);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    redPoint = 255.0f;
    greenPoint = 255.0f;
    bluePoint = 255.0f;
    
    _bgView.backgroundColor = [[UIColor alloc] initWithRed:redPoint green:greenPoint blue:bluePoint alpha:1];
    
   
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

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    ESTBeacon *firstBeacon = [beacons firstObject];
    
    [self updateColorForDistance:[firstBeacon.distance floatValue]];
    [self textForProximity:firstBeacon.proximity];
}

- (void)updateColorForDistance:(float)distance
{
    NSLog(@"distance: %f", distance);
    
    _distanceLabel.text = [NSString stringWithFormat:@"%f", distance];
    
    redPoint = distance / 255.0f;
    greenPoint =  distance / 255.0f;
    bluePoint = distance / 255.0f;
    
    _bgView.backgroundColor = [[UIColor alloc] initWithRed:distance green:distance blue:distance alpha:1];
    
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
            return @"Unknown";
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
